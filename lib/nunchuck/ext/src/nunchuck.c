#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <linux/i2c-dev.h>

typedef struct {
	bool bz;
	bool bc;
	
	float jx;
	float jy;
	
	float ax;
	float ay;
	float az;
	
	const char* port;
	int         addr;
	int         fd;
} Nunchuck;

Nunchuck*
nunchuck_new(int addr, const char* port)
{
	Nunchuck *d = malloc(sizeof(Nunchuck));
	d->port = port;
	d->addr = addr;
	return(d);
}

const char* nunchuck_get_port(Nunchuck* d)
{
	return(d->port);
}

int nunchuck_get_fd(Nunchuck* d)
{
	return(d->fd);
}

bool nunchuck_get_bc(Nunchuck* d)
{
	return(d->bc);
}

bool nunchuck_get_bz(Nunchuck* d)
{
	return(d->bz);
}

float nunchuck_get_ax(Nunchuck* d)
{
	return(d->ax);
}

float nunchuck_get_ay(Nunchuck* d)
{
	return(d->ay);
}

float nunchuck_get_az(Nunchuck* d)
{
	return(d->az);
}

float nunchuck_get_jx(Nunchuck* d)
{
	return(d->jx);
}

float nunchuck_get_jy(Nunchuck* d)
{
	return(d->jy);
}

bool nunchuck_init(Nunchuck* d)
{
	d->fd = open(d->port, O_RDWR);
	if(d->fd<0) return(0);
	if(ioctl(d->fd, I2C_SLAVE, d->addr) < 0) return(0);
	if(write(d->fd, "\x40", 2)<0) return(0);

	return(1);
}

bool nunchuck_read_packet(Nunchuck* d)
{
	int i=0, n=0, readcnt=1;
	
	// loop: read 6 bytes, parse, print
	unsigned char buf[6];
	for(;;)
	{
		n = read(d->fd, buf+i, 1); // read one byte (at index i)
		if(n<0) return(0);
		if(!n) continue;
		buf[i] = (buf[i]^0x17)+0x17;  // decode incoming byte
		if(++i<6) continue;     // continue to read until a packet is complete
		i=0;                    // reset the index

		// 6-byte packet complete
		readcnt++;

		d->jx = buf[0];
		d->jy = buf[1];  // joystick x/y values
		
		d->bz = buf[5]&1 ? 0 : 1;
		d->bc = buf[5]&2 ? 0 : 1;  // keys Z/C
		
		d->ax = (buf[2]<<2)+((buf[5]>>(1+1))&3);         // accelerometer x/y/z values
		d->ay = (buf[3]<<2)+((buf[5]>>(2+2))&3);
		d->az = (buf[4]<<2)+((buf[5]>>(3+3))&3);
				
		write(d->fd, "", 1);       // send a zero to nunchuck to acknowledge the packet
		
		return(1);
	} 	
	
	return(0);
}
