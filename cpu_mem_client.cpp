/*Final*/

#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <time.h>
#include <pthread.h>
#include <fstream>
#include <iostream>

using namespace std;
#define NUM 8
#define MACHINES "/home/hadoopnew/machines"
double cpu_free[NUM];
double mem_free[NUM];
string machines[NUM];//= {"10.6.9.215", "10.6.9.211", "10.6.9.212", "10.6.9.213"};

void get_machines()
{
    ifstream fin;
    int i=0;
    string machine;
    fin.open(MACHINES);
    if(fin.fail())
    {
        printf("Error opening machines file\n");
    }
    while(true)
    {
        fin >> machine;
        if(fin.eof() || i == NUM) break;
        machines[i++] = machine.substr(machine.find('@')+1);
    }
}

void *get_cpu_mem_available(void *data)
{
    int index = (int)data;
    //printf("%s %d\n",machines[index].c_str(),index);
    //cout << machines[index] << index << endl;
    int connection_fd = 0;

    struct sockaddr_in sock;
    char msg[1024];

    sock.sin_family = AF_INET;
    sock.sin_port = htons(1234);

    if (inet_pton(AF_INET, machines[index].c_str(), &sock.sin_addr) < 0) {
        printf("Error\n");
        return NULL;
    }

    if ((connection_fd = socket(AF_INET,SOCK_STREAM,0)) < 0) {
        printf("Error : Could not create socket\n");
        return NULL;
    }


    if (connect (connection_fd, (struct sockaddr*)&sock, sizeof(sock)) < 0) {
        printf("Unable to connect to %s\n",machines[index].c_str());
        return NULL;
    }

    read(connection_fd, msg, 1024);
    long mem_f,mem_t,swap_f,swap_t,net_out;
    sscanf(msg, "%lf %lf %ld %ld %ld %ld %ld",&cpu_free[index], &mem_free[index],&mem_f,&mem_t,&swap_f,&swap_t,&net_out);
    printf("Machine %s CpuFree%% %5.2lf MemFree%% %5.2lf Memfree %ld MB, Memtotal %ld MB, Swapfree %ld MB, Swaptotal %ld MB Netout %ld\n",machines[index].c_str(),cpu_free[index],mem_free[index],mem_f,mem_t,swap_f,swap_t,net_out);

	//shutdown(connection_fd, SHUT_RDWR);
    close(connection_fd);
}

int main(int argc, char* argv[]) {
    int i;
    pthread_t tid[NUM];
    get_machines();
    
	for(i=0; i < NUM; i++)
	{
	    pthread_create(&tid[i],NULL,get_cpu_mem_available,(void *)i);
	}
	for(i=0; i < NUM; i++)
	{
	    pthread_join(tid[i],NULL);
	}
	printf("\n");
    return 0;
}
