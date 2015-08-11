//TCP server
//listen port 9102
//receive string and display it

//Visual C++ 6.0

#include <stdio.h>
#include <winsock2.h>
#include <iostream>
using namespace std;

#pragma comment(lib,"ws2_32.lib")


#define BUFLEN 1024

int main()
{
	SOCKET serversoc;
	SOCKET clientsoc;
	SOCKADDR_IN serveraddr;
	SOCKADDR_IN clientaddr;
	char buf[BUFLEN];
	int len;

	WSADATA wsa;
	WSAStartup(MAKEWORD(1,1),&wsa);	//initial Ws2_32.dll by a process
	if((serversoc = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) <= 0)	//create a tcp socket
	{
		printf("Create socket fail!\n");
		return -1;
	}

	serveraddr.sin_family = AF_INET;
	serveraddr.sin_port = htons(9102);
	serveraddr.sin_addr.S_un.S_addr = htonl(INADDR_ANY);

	//printf("htons: %d"htons(9102) << endl;  
	//cout << "inet_addr: " << inet_addr("127.0.0.1") << endl;  

	if(bind(serversoc, (SOCKADDR *)&serveraddr, sizeof(serveraddr)) != 0)
	{
		printf("Bind fail!\n");
		return -1;
	}

	//start listen, maximum length of the queue of pending connections is 1
	printf("Start listen...\n");
	if(listen(serversoc, 1) != 0)
	{
		printf("Listen fail!\n");
		return -1;
	}

	len = sizeof(SOCKADDR_IN);


	//waiting for connecting
	if((clientsoc = accept(serversoc, (SOCKADDR *)&clientaddr, &len))<=0)
	{
		printf("Accept fail!\n");
		return -1;
	}
	printf("Connected\n");
	while(1)
	{
		//waiting for data receive
		if(recv(clientsoc, buf, BUFLEN, 0) <= 0)	
		{
			//some error occur
			printf("Close connection\n");
			closesocket(clientsoc);
			break;
		}
		printf("user recv: %s\n",buf);
		Sleep(1000);
		if (send(clientsoc, "goodbay", sizeof("goodbay"), 0) <= 0)
		{
			printf("Close connection\n");
			closesocket(clientsoc);
			break;
		}
		printf("user recv: %s\n","goodbay");
	}

	WSACleanup(); //clean up Ws2_32.dll 
	return 0;
}