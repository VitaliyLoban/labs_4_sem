// num6.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
#include "Auxil.h"
#include <iostream>
#include <iomanip> 
#include <time.h>
#include "Salesman.h"
#define SPACE(n) std::setw(n)<<" "
#define N 12
namespace auxil
{
	void start()                          // �����  ���������� ��. �����
	{
		srand((unsigned)time(NULL));
	};
	double dget(double rmin, double rmax) // �������� ��������� �����
	{
		return ((double)rand() / (double)RAND_MAX)*(rmax - rmin) + rmin;
	};
	int iget(int rmin, int rmax)         // �������� ��������� �����

	{
		return (int)dget((double)rmin, (double)rmax);
	};
}
int _tmain(int argc, _TCHAR* argv[])
{
	setlocale(LC_ALL, "rus");
	int d[N*N + 1], r[N];
	auxil::start();
	for (int i = 0; i <= N*N; i++) d[i] = auxil::iget(10, 100);
	std::cout << std::endl << "-- ������ ������������ -- ";
	std::cout << std::endl << "-- ���������� ------ ����������������� -- ";
	std::cout << std::endl << "      �������           ����������  ";
	clock_t t1, t2;
	for (int i = 7; i <= N; i++)
	{
		t1 = clock();
		salesman(i, (int*)d, r);
		t2 = clock();
		std::cout << std::endl << SPACE(7) << std::setw(2) << i
			<< SPACE(15) << std::setw(5) << (t2 - t1);
	}
	std::cout << std::endl;
	system("pause");
	return 0;
}
