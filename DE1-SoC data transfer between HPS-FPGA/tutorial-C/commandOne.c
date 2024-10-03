#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <time.h>
#include <dirent.h>
#include <omp.h>
#include <math.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/mman.h>
#include <sys/time.h>
#include <string.h>

// main bus; scratch RAM
// used only for testing
#define FPGA_ONCHIP_BASE 0xC8000000
#define FPGA_ONCHIP_SPAN 0x00001000

// main bus; FIFO write address
#define FIFO_BASE 0xC0000000
#define FIFO_SPAN 0x00001000

// the read and write ports for the FIFOs
// you need to query the status ports before these operations
// PUSH the write FIFO
// POP the read FIFO
#define FIFO_WRITE (*(FIFO_write_ptr))
#define FIFO_READ (*(FIFO_read_ptr))

/// lw_bus; FIFO status address
#define HW_REGS_BASE 0xff200000
#define HW_REGS_SPAN 0x00005000

// WAIT looks nicer than just braces
#define WAIT {}

// FIFO status registers
// base address is current fifo fill-level
// base+1 address is status: 
// --bit0 signals "full"
// --bit1 signals "empty"
#define WRITE_FIFO_FILL_LEVEL (*FIFO_write_status_ptr)
#define READ_FIFO_FILL_LEVEL  (*FIFO_read_status_ptr)
#define WRITE_FIFO_FULL		  ((*(FIFO_write_status_ptr+1))& 1 ) 
#define WRITE_FIFO_EMPTY	  ((*(FIFO_write_status_ptr+1))& 2 ) 
#define READ_FIFO_FULL		  ((*(FIFO_read_status_ptr+1)) & 1 )
#define READ_FIFO_EMPTY	      ((*(FIFO_read_status_ptr+1)) & 2 )
// arg a is data to be written
#define FIFO_WRITE_BLOCK(a)	  {while (WRITE_FIFO_FULL){WAIT};FIFO_WRITE=a;}
// arg a is data to be written, arg b is success/fail of write: b==1 means success
#define FIFO_WRITE_NOBLOCK(a,b) {b=!WRITE_FIFO_FULL; if(!WRITE_FIFO_FULL)FIFO_WRITE=a; }
// arg a is data read
#define FIFO_READ_BLOCK(a)	  {while (READ_FIFO_EMPTY){WAIT};a=FIFO_READ;}
// arg a is data read, arg b is success/fail of read: b==1 means success
#define FIFO_READ_NOBLOCK(a,b) {b=!READ_FIFO_EMPTY; if(!READ_FIFO_EMPTY)a=FIFO_READ;}

// the light weight buss base
void *h2p_lw_virtual_base;
// HPS_to_FPGA FIFO status address = 0
volatile unsigned int *FIFO_write_status_ptr = NULL;
volatile unsigned int *FIFO_read_status_ptr = NULL;

// RAM FPGA command buffer
// main bus addess 0x0800_0000
volatile unsigned int *sram_ptr = NULL;
void *sram_virtual_base;

// HPS_to_FPGA FIFO write address
// main bus addess 0x0000_0000
void *h2p_virtual_base;
volatile unsigned int *FIFO_write_ptr = NULL;
volatile unsigned int *FIFO_read_ptr = NULL;

// /dev/mem file id
int fd;

// timer variables
struct timeval t1, t2;
double elapsedTime;

//static int verbose_flag = 0;
int helpopt = 0;
int term_out = 0;

int main(void)
{

    // === get FPGA addresses ==================

    if ((fd = open("/dev/mem", (O_RDWR | O_SYNC))) == -1)
    {
        printf("ERROR: could not open \"/dev/mem\"...\n");
        return (1);
    }

    //============================================

    h2p_lw_virtual_base = mmap(NULL, HW_REGS_SPAN, (PROT_READ | PROT_WRITE), MAP_SHARED, fd, HW_REGS_BASE);
    if (h2p_lw_virtual_base == MAP_FAILED)
    {
        printf("ERROR: mmap1() failed...\n");
        close(fd);
        return (1);
    }

    FIFO_write_status_ptr = (unsigned int *)(h2p_lw_virtual_base);

    FIFO_read_status_ptr = (unsigned int *)(h2p_lw_virtual_base + 0x20); //0x20

    //============================================


    sram_virtual_base = mmap(NULL, FPGA_ONCHIP_SPAN, (PROT_READ | PROT_WRITE), MAP_SHARED, fd, FPGA_ONCHIP_BASE);

    if (sram_virtual_base == MAP_FAILED)
    {
        printf("ERROR: mmap3() failed...\n");
        close(fd);
        return (1);
    }

    sram_ptr = (unsigned int *)(sram_virtual_base);

    // ===========================================


    h2p_virtual_base = mmap(NULL, FIFO_SPAN, (PROT_READ | PROT_WRITE), MAP_SHARED, fd, FIFO_BASE);

    if (h2p_virtual_base == MAP_FAILED)
    {
        printf("ERROR: mmap3() failed...\n");
        close(fd);
        return (1);
    }

    FIFO_write_ptr = (unsigned int *)(h2p_virtual_base);
    FIFO_read_ptr = (unsigned int *)(h2p_virtual_base + 0x10); //0x10

    //============================================

    int N = 5;
    
	int data[5], retdata[5];
	
	int i,j, k;
//	data[0]=1;
//	data[1]=1;
//	data[2]=1;
//	data[3]=1;
//	data[4]=1;
	
	for (k=0; k<N; k++)
	{
		data[k] = 1 + k;
		printf("%d\n", data[k]);
	}
	
	for (i=0; i<N; i++)
    {
    	FIFO_WRITE_BLOCK(data[i]);
	}
	usleep(1);
	
	j=0;
	while (!READ_FIFO_EMPTY)
    {
        retdata[j] = FIFO_READ;
        printf("data %d: %d\n", j, retdata[j]);
        j++;
        if(j>4)
        {
        	break;
		}
    }
    
    return 0;
}
//////////////////////////////////////////////////////////////////////////////////
