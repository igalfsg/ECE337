#include <stdio.h> 
#include <stdlib.h>
#include <string.h>
#include <memory.h>

#include "PCIE.h"

//MAX BUFFER FOR DMA
#define MAXDMA 20

//BASE ADDRESS FOR CONTROL REGISTER
#define CRA 0x00000000

//BASE ADDRESS TO SDRAM
#define SDRAM 0x08000000

#define RWSIZE (32 / 8)

PCIE_BAR pcie_bars[] = { PCIE_BAR0, PCIE_BAR1 , PCIE_BAR2 , PCIE_BAR3 , PCIE_BAR4 , PCIE_BAR5 };

typedef struct tagBITMAPFILEHEADER
{
    WORD bfType;  //specifies the file type
    DWORD bfSize;  //specifies the size in bytes of the bitmap file
    WORD bfReserved1;  //reserved; must be 0
    WORD bfReserved2;  //reserved; must be 0
    DWORD bOffBits;  //species the offset in bytes from the bitmapfileheader to the bitmap bits
}BITMAPFILEHEADER;

typedef struct tagBITMAPINFOHEADER
{

    WORD dummy1;  //specifies the number of bytes required by the struct
    /*signed int*/ WORD  width;  //specifies width in pixels
    /*signed int*/ WORD dummy2;  //species height in pixels
    WORD height;
    DWORD dummy3;
    WORD biPlanes; //specifies the number of color planes, must be 1
    WORD biBitCount; //specifies the number of bit per pixel
    DWORD biCompression;//spcifies the type of compression
    DWORD biSizeImage;  //size of image in bytes
    signed int biXPelsPerMeter;  //number of pixels per meter in x axis
    signed int biYPelsPerMeter;  //number of pixels per meter in y axis
    DWORD biClrUsed;  //number of colors used by th ebitmap
    DWORD biClrImportant;  //number of colors that are important
}BITMAPINFOHEADER;

void test32( PCIE_HANDLE hPCIe, DWORD addr );
void testDMA( PCIE_HANDLE hPCIe, DWORD addr);
BOOL WriteStartByte(PCIE_HANDLE hPCIe);
BOOL WriteImage(PCIE_HANDLE hPCIe, char *filename, BITMAPINFOHEADER *info);
BOOL checkImageDone(PCIE_HANDLE hPCIe);
BOOL clearMem(PCIE_HANDLE hPCIe, BITMAPINFOHEADER *info);
BOOL NewReadImage(PCIE_HANDLE hPCIe, BITMAPINFOHEADER *info);
void Demo(PCIE_HANDLE hPCIe, char *filename);
BOOL WriteInfo2(PCIE_HANDLE hPCIe, BITMAPINFOHEADER *info);

int main( int argc, char *argv[])
{
	printf("\nsize of header: %lu\n",sizeof(BITMAPINFOHEADER));
	if(argc != 3 && argc != 2)
	{
	 	printf("Wrong command. Use **./app -h** for help.\n");
	 	return 0;
	 }
	
	void *lib_handle;
	PCIE_HANDLE hPCIe;

	lib_handle = PCIE_Load();
	if (!lib_handle)
	{
		printf("PCIE_Load failed\n");
		return 0;
	}
	hPCIe = PCIE_Open(0,0,0);

	if (!hPCIe)
	{
		printf("PCIE_Open failed\n");
		return 0;
	}
	//PCIE_Write32( hPCIe, pcie_bars[0], SDRAM, 0xdeadbeef);
	//testDMA(hPCIe,0x08000000);
	
	char* input = argv[1];
	if (strcmp("-d",input)==0)
	{
		Demo(hPCIe, argv[2]);
	}
	else if(strcmp("-h",input)==0)
	{
		printf("Use **./app -d <imagefilename>** to start demo.\n");	
	}
	else {
		printf("Wrong command. Use **./app -h** for help.\n");
	}
	
	return 0;
}

// Main demo process
void Demo(PCIE_HANDLE hPCIe, char *filename)
{

	BITMAPINFOHEADER info;

	printf("\n\n");

	if(!WriteImage(hPCIe, filename, &info))
		return; //dancing.bmp

	/*if(!WriteInfo2(hPCIe, &info))
		return; //dancing.bmp*/

	/*if(!WriteStartByte(hPCIe))
		return;

	printf("\nStarting Filter! :)\n");
	while(!checkImageDone(hPCIe));
	printf("\nFilter Done! :D\n");*/
	if(!NewReadImage(hPCIe, &info))
		return; //dancing.bmp
	/*if(!clearMem(hPCIe, &info))
		return;
	printf("To copy the output image to your own account, use\n scp out.bmp mgXXX@ecegrid.ecn.purdue.edu:~/Desktop/. \n");
	*/
	
	printf("\n\n");
	return;
}

// Read the processed edge image from SDRAM and write it to a new BMP image named "out.bmp"
BOOL NewReadImage(PCIE_HANDLE hPCIe, BITMAPINFOHEADER *info) 
{
	//checkImageDone(hPCIe);
	system("cp spon5.bmp out.bmp");
	wait(5);
	//return TRUE;
	FILE* fp = fopen("out.bmp", "rb+");
	
    //static unsigned char //color[1], /* 1 byte = 8 bits */
                 //        byte[1];
    //unsigned short word[1]; /* 2 bytes */
    //unsigned long  dword[1], /* 4 bytes */
            //       bpp=1,
                   /* in bytes */
              /*     FileHeaderSize=14, 
                   InfoHeaderSize=40, // header_bytes
                   PaletteSize=255*4, // = 8 = number of bytes in palette, 256 colors
                   BytesPerRow,
                   FileSize,
                   OffBits,
                   BytesSize, // bytes in image portion
                   //iByte, // number of byte
                   /* in pixels 
                   Width= info->width, 
                   Height= info->height;
                   /* in ... */
                   //ix, iy, ix_,
                   //bit=0, /* bit value */
                   //bitNumber; /* bits are numberd from 0 to 7 */
/*
    BytesPerRow=(((Width * bpp)+31)/32)*4; 
    BytesSize=BytesPerRow*Height;
    FileSize=FileHeaderSize+InfoHeaderSize+PaletteSize+BytesSize;
    OffBits=FileHeaderSize+InfoHeaderSize+PaletteSize;

    word[0]=19778;                                         fwrite(word,1,2,fp); /* file Type signature = BM 
    dword[0]=FileSize;                                     fwrite(dword,1,4,fp); /* FileSize 
    word[0]=0;                                             fwrite(word,1,2,fp); /* reserved1 
    word[0]=0;                                             fwrite(word,1,2,fp); /* reserved2 
    dword[0]=OffBits;                                      fwrite(dword,1,4,fp); /* OffBits 
    dword[0]=InfoHeaderSize;                               fwrite(dword,1,4,fp); 
    dword[0]=Width;                                        fwrite(dword,1,4,fp); 
    dword[0]=Height;                                       fwrite(dword,1,4,fp); 
    word[0]=1;                                             fwrite(word,1,2,fp); /* planes 
    word[0]=8;                                             fwrite(word,1,2,fp); /* Bits of color per pixel */
  //  dword[0]=0;                                            fwrite(dword,1,4,fp); /* compression type 
   // dword[0]=0;                                            fwrite(dword,1,4,fp); /* Image Data Size, set to 0 when no compression 
   /* dword[0]=0;                                            fwrite(dword,1,4,fp);   
    dword[0]=0;                                            fwrite(dword,1,4,fp); /*  
    dword[0]=255;                                          fwrite(dword,1,4,fp); /*  number of used coloors
    dword[0]=0;                                            fwrite(dword,1,4,fp); /*  
 
    int i;
    for (i = 0; i < 256; i++)
    {
    	byte[0]=i;                                            fwrite(byte,1,1,fp); /* R 
		byte[0]=i;                                            fwrite(byte,1,1,fp);  */                                     
		//byte[0]=i;                                            fwrite(byte,1,1,fp); /* G    
		//byte[0]=i;                                            fwrite(byte,1,1,fp); /* B  
   // }          

    DWORD addr = 0x08000000; //new image starts from 0x08500000

	unsigned char *testImage;//test image buffer
	testImage = (unsigned char*)malloc(info->width*info->height*4*sizeof(unsigned char));
	BOOL bPass = PCIE_DmaRead(hPCIe, addr, testImage, info->width*info->height*4);
	if(!bPass)
	{
		printf("ERROR: unsuccessful image reading.\n");
		return FALSE;
	}
	else
		printf("Image read by the Atom.\n");


	unsigned char *bitmapImage;//image buffer
	bitmapImage = (unsigned char*)malloc(info->width*info->height*3*sizeof(unsigned char));
	int index = 0;
	int j;
	// Store only the LSByte of the 32-bit data into the new image file
	/*for (j = 0; j < info->width*info->height; ++j)
	{
		unsigned char buff;
		buff = testImage[index++];
		bitmapImage[j] = buff;
		buff = testImage[index++];
		buff = testImage[index++];
		buff = testImage[index++];
	}*/

	int row;
	int col;
	int count = 0;
	unsigned char * b_arr = malloc(sizeof(unsigned char)*info->width*info->height);
	unsigned char * g_arr = malloc(sizeof(unsigned char)*info->width*info->height);
	unsigned char * r_arr = malloc(sizeof(unsigned char)*info->width*info->height);
	for (row = 479; row > -1; row--)
	{
	  for (col = 0; col < 640; col++)
	  {
		r_arr[count] = testImage[(640*row + col)*4];
		g_arr[count] = testImage[(640*row + col)*4+1];
		b_arr[count] = testImage[(640*row + col)*4+2];
		count++;
	  }
	}
	int i = 0;
	int arr_i = 0;
	while (i+2 < info->width*info->height*3)
	{
	  	bitmapImage[i] = r_arr[arr_i]; //FLIPPED
		bitmapImage[i+1] = g_arr[arr_i];
		bitmapImage[i+2] = b_arr[arr_i];
		i += 3;
		arr_i += 1;
	}
	for (i = 1920; i < 1960; i+=3)
	{
	printf("%d\t%d %d %d\n",i,bitmapImage[i],bitmapImage[i+1],bitmapImage[i+2]);
	}
	if(!bitmapImage)
	{
		printf("ERROR: new image is empty.\n");
		return FALSE;
	}
	fseek(fp,54,SEEK_SET);
	fwrite(bitmapImage, info->width*info->height*3*sizeof(unsigned char),1,fp);
	free(bitmapImage);
	free(testImage);
	fclose(fp);
	printf("New image written to **out.bmp**.\n");
	return TRUE;
}

// Write STARTBYTE to slave register in user_module.sv
BOOL WriteStartByte(PCIE_HANDLE hPCIe)
{
	DWORD addr = 0x00000000;
	BYTE start = 0x53;

	BOOL bPass = PCIE_Write32( hPCIe, pcie_bars[0], addr, start);
	if(!bPass)
	{
		printf("ERROR: unsuccessful start byte writing.\n");
		return FALSE;
	}
	else
		printf("Start byte written.\n");
	return TRUE;
}

// Write image info to slave register in user_module.sv
BOOL WriteInfo2(PCIE_HANDLE hPCIe, BITMAPINFOHEADER *info)
{

	printf("INFO: width = %d pixels; height = %d pixels\n", info->width, info->height);

	WORD tempw = info->width;
	WORD temph = info->height;

	DWORD addr = 0x04;
	//BYTE start = 0x04;
	PCIE_Write32( hPCIe, pcie_bars[0], addr, *((unsigned char *)&tempw + 1) ) ;  //01
	addr = addr+4;
    PCIE_Write32( hPCIe, pcie_bars[0], addr, *((unsigned char *)&tempw + 0)); //f4
	addr = addr+4;
	PCIE_Write32( hPCIe, pcie_bars[0], addr, *((unsigned char *)&temph + 1)); //01
	addr = addr+4;
	BOOL bPass = PCIE_Write32( hPCIe, pcie_bars[0], addr, *((unsigned char *)&temph + 0)); //4d

	if(!bPass)
	{
		printf("ERROR: unsuccessful image info writing.\n");
		return FALSE;
	}
	else
		printf("Image info written.\n");
	return TRUE;
}

// Write the image field 2 times to SDRAM
BOOL WriteImage(PCIE_HANDLE hPCIe,  char *filename, BITMAPINFOHEADER *info)
{
	FILE * pFile;
 	pFile = fopen(filename,"rb");
	BITMAPFILEHEADER bitmapFileHeader; 
  	fread(&bitmapFileHeader, sizeof(BITMAPFILEHEADER),1,pFile);
	//FILE * fp = fopen("out.bmp","wb");
	//fwrite(&bitmapFileHeader, sizeof(BITMAPFILEHEADER),1,fp);
	
	BITMAPFILEHEADER x;
	
	//read the info header
	fread(info, sizeof(BITMAPINFOHEADER),1,pFile); // now info contains the header info
	//fwrite(info, sizeof(BITMAPINFOHEADER),1,fp);
	//fclose(fp);
	unsigned char *bitmapImage;//image buffer
	bitmapImage = (unsigned char*)malloc(info->width*info->height*3*sizeof(unsigned char));
	if (!bitmapImage)
   	{
        	free(bitmapImage);
        	fclose(pFile);
			printf("Image loading failed.\n");
        	return FALSE;
    }

	//read in the bitmap image data
	fseek(pFile,54,SEEK_SET);
  	fread(bitmapImage,info->width*info->height*3*sizeof(unsigned char),1,pFile); // pic content in bitmapImage
	
	
	DWORD addr = 0x08000000;  //original image written starting from 0x08000000
	DWORD addr2 = 0x0812C000; // writing image to second location as well right under first

	// Write only one pixel to the LSByte and zero pad the rest 8 bits
	unsigned char *imageDataBuffer;
	// separate arrays to keep track of RGB	
	unsigned char * b_arr = malloc(sizeof(unsigned char)*info->width*info->height);
	unsigned char * g_arr = malloc(sizeof(unsigned char)*info->width*info->height);
	unsigned char * r_arr = malloc(sizeof(unsigned char)*info->width*info->height);
	
	//Loading the rgb arrays with values
	int i = 0;
	int arr_i = 0;
	while (i+2 < info->width*info->height*3)
	{
	  	b_arr[arr_i] = bitmapImage[i];
		g_arr[arr_i] = bitmapImage[i+1];
		r_arr[arr_i] = bitmapImage[i+2];
		i += 3;
		arr_i += 1;
	}
	
	// Filling imageDataBuffer in order of BMP format
	imageDataBuffer = (unsigned char*)malloc(info->width*info->height*4*sizeof(unsigned char));
	int index = 0;
	int row;
	int col;
	int count = 0;

	for (row = 479; row > -1; row--)
	{
	  for (col = 0; col < 640; col++)
	  {
		imageDataBuffer[(640*row + col)*4] = 0;
		imageDataBuffer[(640*row + col)*4+1] = r_arr[count];
		imageDataBuffer[(640*row + col)*4+2] = g_arr[count];
		imageDataBuffer[(640*row + col)*4+3] = b_arr[count];
		count++;
	  }
	}
	
	
	//Write and check image
	BOOL bPass = PCIE_DmaWrite(hPCIe, addr, imageDataBuffer, info->width*info->height*4);
	if(!bPass)
	{
		printf("ERROR: unsuccessful image writing.\n");
		return FALSE;
	}
	else
		printf("Image written.\n");
	
	//Write and check second image
    	bPass = PCIE_DmaWrite(hPCIe, addr2, imageDataBuffer, info->width*info->height*4);
	if(!bPass)
	{
		printf("ERROR: unsuccessful image writing.\n");
		return FALSE;
	}
	else
		printf("Image written.\n");

	
	/*
	1st Image:
		Top Left: 		0x08000000
		Middle Left:		0x08000A00
		Bottom Left:		0x08001400
		Bottom Bottom Left:	0x0812B600
		LAST:			0x0812BFFC
	2nd Image:
		Top Left:		0x0812C000
		Middle Left:		0x0812CA00
		Bottom Left:		0x0812D400
		Bottom Bottom Left:	0x08257600
		LAST:			0x08257FFC
	*/

	// ****************** TEST CODE *************************
	int dummy;
	scanf("%d",&dummy);
	unsigned char* testbuffer = malloc(32*sizeof(unsigned char));
	DWORD start = 0x08000A04;
	DWORD test2 = start; 
	DWORD test3 = start + 32; 
	DWORD test4 = start + 64; 
	DWORD test5 = start + 96; 
	
	bPass = PCIE_DmaRead(hPCIe,test2,testbuffer,32);
	for(i=0;i<32;i+=4)
	{
	printf("Pixel %d:  %d %d %d %d\n",i/4,testbuffer[i], testbuffer[i+1],testbuffer[i+2],testbuffer[i+3]);
	}
	bPass = PCIE_DmaRead(hPCIe,test3,testbuffer,32);
	for(i=0;i<32;i+=4)
	{
	printf("Pixel %d:  %d %d %d %d\n",i/4,testbuffer[i], testbuffer[i+1],testbuffer[i+2],testbuffer[i+3]);
	}
	bPass = PCIE_DmaRead(hPCIe,test4,testbuffer,32);
	for(i=0;i<32;i+=4)
	{
	printf("Pixel %d: R: %d G: %d B: %d\n",i/4+16,testbuffer[i+1],testbuffer[i+2],testbuffer[i+3]);
	}
	bPass = PCIE_DmaRead(hPCIe,test5,testbuffer,32);
	for(i=0;i<32;i+=4)
	{
	printf("Pixel %d: R: %d G: %d B: %d\n",i/4+24,testbuffer[i+1],testbuffer[i+2],testbuffer[i+3]);
	}
	free(testbuffer);
	
	
	free(bitmapImage);
	free(imageDataBuffer);
	return TRUE;
}

// Check whether an image is finished by looking for STOPBYTE in slave register[0]
BOOL checkImageDone(PCIE_HANDLE hPCIe)
{
   BYTE b;
   DWORD addr = 0x00000000;
   BOOL bPass = PCIE_Read8( hPCIe, pcie_bars[0], addr, &b);
   BYTE check = 0x12;
   if(bPass)
   {
      if(b == check)
      {
      	printf("Image done\n");
		return TRUE;
      }
      else
      {
      	printf("Image not done yet\n");
      	return FALSE;
      }
   }
   return FALSE;
}

// Test whether PCIe is functional
void test32( PCIE_HANDLE hPCIe, DWORD addr )
{
	BOOL bPass;
	DWORD testVal = 0xf;
	DWORD readVal;

	WORD i = 0;
	for (i = 0; i < 16 ; i++ )
	{
		printf("Testing register %d at addr %x with value %x\n", i, addr, testVal);
		bPass = PCIE_Write32( hPCIe, pcie_bars[0], addr, testVal);
		if (!bPass)
		{
			printf("test FAILED: write did not return success\n");
			return;
		}
		bPass = PCIE_Read32( hPCIe, pcie_bars[0], addr, &readVal);
		if (!bPass)
		{
			printf("test FAILED: read did not return success\n");
			return;
		}
		if (testVal == readVal)
		{
			printf("Test PASSED: expected %x, received %x\n", testVal, readVal);
		}
		else
		{
			printf("Test FAILED: expected %x, received %x\n", testVal, readVal);
		}
		testVal = testVal + 1;
		addr = addr + 4;
	}
	return;
}

// Clean all the memories used in the demo
BOOL clearMem(PCIE_HANDLE hPCIe, BITMAPINFOHEADER *info)
{

	DWORD addr = 0x00;
	//BYTE start = 0x04;
	PCIE_Write8( hPCIe, pcie_bars[0], addr, 0x00);
	addr = addr+4;
	PCIE_Write8( hPCIe, pcie_bars[0], addr, 0x00);
	addr = addr+4;
    PCIE_Write8( hPCIe, pcie_bars[0], addr, 0x00);//r_addr
	addr = addr+4;
	PCIE_Write8( hPCIe, pcie_bars[0], addr, 0x00);
	addr = addr+4;
	PCIE_Write8( hPCIe, pcie_bars[0], addr, 0x00);

	unsigned char *testImage;//test image buffer
	testImage = (unsigned char*)malloc(info->width*info->height*4*sizeof(unsigned char));
	
	addr = 0x08000000;
	BOOL bPass = PCIE_DmaWrite(hPCIe, addr, testImage, info->width*info->height*4);

	if (!bPass)
	{
		printf("ERROR: unsuccessful memory clearing 1.\n");
		return FALSE;
	}

	addr = 0x08500000;
	int i;
	for ( i = 0; i < info->width*info->height*4; ++i)
	{
		testImage[i] = 0;
	}

	bPass = PCIE_DmaWrite(hPCIe, addr, testImage, info->width*info->height*4);

	if (!bPass)
	{
		printf("ERROR: unsuccessful memory clearing 2.\n");
		return FALSE;
	}

//	printf("All memory cleared.\n");
	return TRUE;
}

//tests DMA write of buffer to address
void testDMA( PCIE_HANDLE hPCIe, DWORD addr)
{
	BOOL bPass;
	DWORD testArray[MAXDMA];
	DWORD readArray[MAXDMA];
	
	WORD i = 0;
	
	while ( i < MAXDMA )
	{
		testArray[i] = i  + 0xfd;
		i++;
	}

	bPass = PCIE_DmaWrite(hPCIe, addr, testArray, MAXDMA * RWSIZE );
	if (!bPass)
	{
		printf("test FAILED: write did not return success");
		return;
	}
	bPass = PCIE_DmaRead(hPCIe, addr, readArray, MAXDMA * RWSIZE );
	if (!bPass)
	{
		printf("test FAILED: read did not return success");
		return;
	}
	i = 0;
	while ( i < MAXDMA )
	{
		if (testArray[i] == readArray[i])
		{
			printf("Test PASSED: expected %x, received %x\n", testArray[i], readArray[i]);
		}
		else
		{
			printf("Test FAILED: expected %x, received %x\n", testArray[i], readArray[i]);
		}
		i++;
	}
	DWORD * testbuffer2 = malloc(sizeof(DWORD));
	unsigned char* testbuffer = malloc(16*sizeof(unsigned char));
printf("SIZE OF DWORD %d\n",sizeof(DWORD));
printf("SIZE OF CHAR %d\n",sizeof(unsigned char));
	DWORD test2 = 0x08000000; //TOP LEFT
	DWORD test3 = 0x08000004; // 3rd [2,0]
	DWORD test4 = 0x08000008; // top left [0,0]
	DWORD test5 = 0x0800000C; // diagonal [1,1]
	DWORD test6 = 0x08000010; // diagonal [1,1]
	DWORD test7 = 0x08000014; // diagonal [1,1]
	DWORD test8 = 0x08000018; // top left [0,0]
	DWORD test9 = 0x0800001C; // diagonal [1,1]
	DWORD test10 = 0x08000020; // diagonal [1,1]
	DWORD test11 = 0x08000024; // diagonal [1,1]
	//DWORD addr_list[9] = {0x08000000,0x08000004,0x08000008,0x0800000C,0x08000010,0x08000014,0x08000018,0x0800001C};
	DWORD addr_list[9] = {0x08000000,0x08000001,0x08000002,0x08000003,0x08000004,0x08000005,0x08000006,0x08000007,0x08000008};
	for(i=0; i<9; i++)
	{
	bPass = PCIE_DmaRead(hPCIe,addr_list[i],testbuffer2,4);
	printf("%d: %x %X %d\n",i,testbuffer2[0],addr_list[i],bPass);
	}	
	
	printf("\n\n");
	bPass = PCIE_DmaRead(hPCIe,test2,testbuffer,16);
	printf("0: %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x%X %d\n",testbuffer[0],testbuffer[1],testbuffer[2],testbuffer[3],testbuffer[4],testbuffer[5],testbuffer[6],testbuffer[7],testbuffer[8],testbuffer[9],testbuffer[10],testbuffer[11],testbuffer[12],testbuffer[13],testbuffer[14],testbuffer[15],test2,bPass);
	/*bPass = PCIE_DmaRead(hPCIe,test3,testbuffer,1);
	printf("1: %x %x %x %x %X %d\n",testbuffer[0],testbuffer[1],testbuffer[2],testbuffer[3],test3,bPass);
	bPass = PCIE_DmaRead(hPCIe,test4,testbuffer,1);
	printf("2: %x %x %x %x %X %d\n",testbuffer[0],testbuffer[1],testbuffer[2],testbuffer[3],test4,bPass);
	bPass = PCIE_DmaRead(hPCIe,test5,testbuffer,1);
	printf("3: %x %x %x %x %X %d\n",testbuffer[0],testbuffer[1],testbuffer[2],testbuffer[3],test5,bPass);
	bPass = PCIE_DmaRead(hPCIe,test6,testbuffer,4);
	printf("4: %x %x %x %x %X %d\n",testbuffer[0],testbuffer[1],testbuffer[2],testbuffer[3],test6,bPass);
	bPass = PCIE_DmaRead(hPCIe,test7,testbuffer,4);
	printf("2: %x %x %x %x %X %d\n",testbuffer[0],testbuffer[1],testbuffer[2],testbuffer[3],test7,bPass);
	bPass = PCIE_DmaRead(hPCIe,test8,testbuffer,4);
	printf("3: %x %x %x %x %X %d\n",testbuffer[0],testbuffer[1],testbuffer[2],testbuffer[3],test8,bPass);
	bPass = PCIE_DmaRead(hPCIe,test9,testbuffer,4);
	printf("4: %x %x %x %x %X %d\n",testbuffer[0],testbuffer[1],testbuffer[2],testbuffer[3],test9,bPass);*/
		
	return;
}
