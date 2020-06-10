// sss.cpp: определяет точку входа для консольного приложения.
//
#include "stdafx.h"
#include <iostream>
#include <iomanip> 
#include "Salesman.h"
#include <time.h>

#define N 5
int _tmain(int argc, _TCHAR* argv[])
{
	setlocale(LC_ALL, "rus");
	int d[N][N]/*;
	int i, j;
	srand((unsigned)time(NULL));
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			if ((i == 3 && j == 2)||( i == 6 && j == 8)||(i==4&&j==7))
				d[i][j] = INF;
			else if (i == j)
				d[i][j] = 0;
			else
				d[i][j] = (rand() % 290) + 10;
		}
	}*/
	= { //0   1    2    3     4        
		{ INF,  126, 34,  INF,   13 },    //  0
		{ 13,   INF,  28,  55,  71 },    //  1
		{ 15,  39,   INF,  86,   62 },    //  2 
		{ 30, 45,    52,   INF,   39 },    //  3
		{ 80,  79,  52,  26,    INF } };   //  4  
	int r[N];                     // ��������� 
	int s = salesman(
		N,          // [in]  ���������� ������� 
		(int*)d,          // [in]  ������ [n*n] ���������� 
		r           // [out] ������ [n] ������� 0 x x x x  
	);
	std::cout << std::endl << "-- ������ ������������ -- ";
	std::cout << std::endl << "-- ����������  �������: " << N;
	std::cout << std::endl << "-- ������� ���������� : ";
	for (int i = 0; i < N; i++)
	{
		std::cout << std::endl;
		for (int j = 0; j < N; j++)

			if (d[i][j] != INF) std::cout << std::setw(3) << d[i][j] << " ";

			else std::cout << std::setw(3) << "INF" << " ";
	}
	std::cout << std::endl << "-- ����������� �������: ";
	for (int i = 0; i < N; i++) std::cout << r[i]+1 << "-->"; std::cout << r[0]+1;
	std::cout << std::endl << "-- ����� ��������     : " << s;
	std::cout << std::endl;
	system("pause");
	return 0;
}
