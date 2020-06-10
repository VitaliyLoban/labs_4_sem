// --- main  
//    расстановка скобок  
#include "stdafx.h"
#include <cmath>
#include <memory.h>
#include <iostream>
#include <time.h>
#include "MultiMatrix.h"   // умножение матриц 

#define N 6
int main()
{
	clock_t t1, t2, t3, t4;
	int Mc[N + 1] = { 9, 12, 20, 23, 30, 40, 51 }, Ms[N][N], r = 0, rd = 0;

	memset(Ms, 0, sizeof(int)*N*N);
	t1 = clock();
	r = OptimalM(1, N, N, Mc, OPTIMALM_PARM(Ms));
	t2 = clock();
	setlocale(LC_ALL, "rus");
	std::cout << std::endl;
	std::cout << std::endl << "-- расстановка скобок (рекурсивное решение)" << std::endl;
	std::cout << std::endl << "размерности матриц: ";
	for (int i = 1; i <= N; i++) std::cout << "(" << Mc[i - 1] << "," << Mc[i] << ") ";
	std::cout << std::endl << "минимальное количество операций умножения: " << r;
	std::cout << std::endl << "затраченное время: " << t2 - t1;
	std::cout << std::endl << std::endl << "матрица S" << std::endl;
	for (int i = 0; i < N; i++)
	{
		std::cout << std::endl;
		for (int j = 0; j < N; j++)  std::cout << Ms[i][j] << "  ";
	}
	std::cout << std::endl;

	memset(Ms, 0, sizeof(int)*N*N);
	t4 = clock();
	rd = OptimalMD(N, Mc, OPTIMALM_PARM(Ms));
	t3 = clock();
	std::cout << std::endl << "-- расстановка скобок (динамичеое программирование) " << std::endl;
	std::cout << std::endl << "размерности матриц: ";
	for (int i = 1; i <= N; i++)
		std::cout << "(" << Mc[i - 1] << "," << Mc[i] << ") ";
	std::cout << std::endl << "минимальное количество операций умножения: " << rd;
	std::cout << std::endl << "затраченное время: " << t4 - t3;
	std::cout << std::endl << std::endl << "матрица S" << std::endl;
	for (int i = 0; i < N; i++)
	{
		std::cout << std::endl;
		for (int j = 0; j < N; j++)  std::cout << Ms[i][j] << "  ";
	}
	std::cout << std::endl << std::endl;
	system("pause");

	return 0;
}