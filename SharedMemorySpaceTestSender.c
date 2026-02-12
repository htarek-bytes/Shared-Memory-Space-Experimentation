#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/shm.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>

#define BUFFER_SIZE 1024 // Max buffer to exchange string

int main(){

    const char *name = "My_Shared_Memory_Space";

    const char *firstMessage = "This is a sequence ";
    const char *secondMessage = "of bytes.";
    
    int sharedMemFileDescriptor;

    void *ptr; //opaque ptr toward the object in shared memory 
    
    
    // Creating the actual space
    sharedMemFileDescriptor = shm_open(name, O_CREAT | O_RDWR, 0666);
    
    // Setting the size of the file that is referenced by the FileDescriptor (a number)
    // In this case, we set it to a size of 1024 bytes, so a 1 kilo byte (1 KB)
    ftruncate(sharedMemFileDescriptor, BUFFER_SIZE);

    ptr = mmap(0,BUFFER_SIZE,PROT_WRITE, MAP_SHARED, sharedMemFileDescriptor, 0);

    sprintf(ptr, "%s", firstMessage);
    ptr += strlen(firstMessage);
    sprintf(ptr,"%s", secondMessage);
}
