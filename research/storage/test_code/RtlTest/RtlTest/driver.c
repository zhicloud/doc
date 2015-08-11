#ifdef __cplusplus
extern "C"
{
#endif
#include "ksocket.h"
#ifdef __cplusplus
}
#endif

#include "driver.h"

//#include <stdio.h>
//#include <stdlib.h>

#define BUFFER_SIZE 1024
NTSTATUS
RtlTestThread(IN PVOID Context)
{
	struct sockaddr_in  toAddr;
	int					status, nSent, nRecv;
	unsigned int		dataLen;
	char				*request, *buffer, *pDataPart;
	INT_PTR				kSocket;
	NTSTATUS			retStatus;
	int i;

	request = (char *)ExAllocatePool(PagedPool, PAGE_SIZE);
	if (request == NULL)
	{
		retStatus = STATUS_INSUFFICIENT_RESOURCES;
		return retStatus;
	}

	buffer = (char *)ExAllocatePool(PagedPool, BUFFER_SIZE);
	if (buffer == NULL)
	{
		ExFreePool(request);
		retStatus = STATUS_INSUFFICIENT_RESOURCES;
		return retStatus;
	}

	kSocket = socket(AF_INET, SOCK_STREAM, 0);
	if (kSocket == -1)
	{
		KdPrint(("RtlTestThread: socket() error\n"));
		ExFreePool(request);
		ExFreePool(buffer);
		retStatus = STATUS_INSUFFICIENT_RESOURCES;
		return retStatus;
	}

	toAddr.sin_family = AF_INET;
	toAddr.sin_port = 36387;//htons(9102);
	toAddr.sin_addr.s_addr = 16777343;//inet_addr("127.0.0.1");

	status = connect(kSocket, (struct sockaddr*)&toAddr, sizeof(toAddr));

	if (status < 0)
	{
		KdPrint(("RtlTestThread: connect() error: %#x\n", status));
		ExFreePool(request);
		ExFreePool(buffer);
		close(kSocket);
		return status;
	}

	strcpy(request, "hello");
	for (i = 0; i<100; i++)
	{
		KdPrint(("kernel send: %s", request));
		nSent = send(kSocket, request, strlen(request), 0);
		if (nSent < 0)
		{
			KdPrint(("RtlTest: send() error: %#x\n", nSent));
			ExFreePool(request);
			ExFreePool(buffer);
			close(kSocket);
			return nSent;
		}
		KdPrint(("kernel send: hello"));

		nRecv = recv(kSocket, buffer, BUFFER_SIZE, 0);
		if (nRecv < 0)
		{
			KdPrint(("RtlTest: recv() error: %#x\n", nRecv));
			ExFreePool(request);
			ExFreePool(buffer);
			close(kSocket);
			return nRecv;
		}
		KdPrint(("kernel recv: goodbay"));
	}
	close(kSocket);
	ExFreePool(request);
	ExFreePool(buffer);
	return STATUS_SUCCESS;
}

//#pragma INITCODE
VOID RtlTest()
{
	PUCHAR pBuffer;
	ULONG ulRet;
	PUCHAR pBuffer2;
	pBuffer= (PUCHAR)ExAllocatePool(PagedPool, BUFFER_SIZE);
	//用零填充内存
	RtlZeroMemory(pBuffer, BUFFER_SIZE);

	pBuffer2 = (PUCHAR)ExAllocatePool(PagedPool, BUFFER_SIZE);
	RtlFillMemory(pBuffer2, BUFFER_SIZE, 0XAA);

	RtlCopyMemory(pBuffer, pBuffer2, BUFFER_SIZE);

	ulRet = RtlCompareMemory(pBuffer, pBuffer2, BUFFER_SIZE);
	if (ulRet == BUFFER_SIZE)
	{
		KdPrint(("The two blocks are same.\n"));
	}
}

//#pragma INITCODE
NTSTATUS DriverEntry(
								IN PDRIVER_OBJECT pDriverObject,
								IN PUNICODE_STRING pRegistryPath)
{
	NTSTATUS status;
#if DBG
	_asm int 3
#endif
		KdPrint(("Enter DriverEntry\n"));

	pDriverObject->DriverUnload = HelloDDKUnload;
	pDriverObject->MajorFunction[IRP_MJ_CREATE] = HelloDDKDispatchRoutine;
	pDriverObject->MajorFunction[IRP_MJ_CLOSE] = HelloDDKDispatchRoutine;
	pDriverObject->MajorFunction[IRP_MJ_READ] = HelloDDKDispatchRoutine;
	pDriverObject->MajorFunction[IRP_MJ_WRITE] = HelloDDKDispatchRoutine;

	status = CreateDevice(pDriverObject);

	RtlTest();

	KdPrint(("DriverEntry end\n"));
	return status;
}

//#pragma INITCODE
NTSTATUS CreateDevice(IN PDRIVER_OBJECT pDriverObject)
{
	NTSTATUS status;
	PDEVICE_OBJECT pDevObj;
	PDEVICE_EXTENSION pDevExt;
	HANDLE thread_handle;
	UNICODE_STRING devName;
	UNICODE_STRING symLinkName;

	RtlInitUnicodeString(&devName, L"\\Device\\RtlTestDevice");

	//创建设备
	status = IoCreateDevice(pDriverObject,
		sizeof(DEVICE_EXTESION),
		&devName,
		FILE_DEVICE_UNKNOWN,
		0, TRUE,
		&pDevObj);
	if (!NT_SUCCESS(status))
		return status;

	pDevObj->Flags |= DO_BUFFERED_IO;
	pDevExt = (PDEVICE_EXTENSION)pDevObj->DeviceExtension;
	pDevExt->pDevice = pDevObj;
	pDevExt->ustrDeviceName = devName;

	status = PsCreateSystemThread(
		&thread_handle,
		(ACCESS_MASK)0L,
		NULL,
		NULL,
		NULL,
		(PKSTART_ROUTINE)RtlTestThread,
		pDevObj);
	if (!NT_SUCCESS(status))
	{
		IoDeleteDevice(pDevObj);
		return status;
	}

	status = ObReferenceObjectByHandle(
		thread_handle,
		THREAD_ALL_ACCESS,
		NULL,
		KernelMode,
		&pDevExt->thread_pointer,
		NULL);

	if (!NT_SUCCESS(status))
	{
		ZwClose(thread_handle);
		IoDeleteDevice(pDevObj);
		return status;
	}
	ZwClose(thread_handle);

	RtlInitUnicodeString(&symLinkName, L"\\??\\RtlTest");
	pDevExt->ustrSymLinkName = symLinkName;
	status = IoCreateSymbolicLink(&symLinkName, &devName);
	if (!NT_SUCCESS(status))
	{
		IoDeleteDevice(pDevObj);
		return status;
	}

	return STATUS_SUCCESS;
}

//#pragma PAGEDCODE
VOID HelloDDKUnload(IN PDRIVER_OBJECT pDriverObject)
{
	PDEVICE_OBJECT pNextObj;
	KdPrint(("Enter DriverUnload\n"));
	pNextObj = pDriverObject->DeviceObject;
	while (pNextObj != NULL)
	{
		PDEVICE_EXTENSION pDevExt = (PDEVICE_EXTENSION)
			pNextObj->DeviceExtension;
		UNICODE_STRING pLinkName = pDevExt->ustrSymLinkName;
		IoDeleteSymbolicLink(&pLinkName);
		pNextObj = pNextObj->NextDevice;
		ObDereferenceObject(pDevExt->thread_pointer);
		IoDeleteDevice(pDevExt->pDevice);
	}
}

//#pragma PAGEDCODE
NTSTATUS HelloDDKDispatchRoutine(IN PDEVICE_OBJECT pDevObj, IN PIRP pIrp)
{
	NTSTATUS status;
	KdPrint(("Enter HelloDDKDispatchRoutine\n"));
	status = STATUS_SUCCESS;
	//完成IRP
	pIrp->IoStatus.Status = status;
	pIrp->IoStatus.Information = 0;
	IoCompleteRequest(pIrp, IO_NO_INCREMENT);
	KdPrint(("Leave HelloDDKDispatchRoutine\n"));
	return status;
}