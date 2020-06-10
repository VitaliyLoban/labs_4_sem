//// mathProg4.cpp: определяет точку входа для консольного приложения.
////
//#include "stdafx.h"
//#include <iostream>
//#include <stdlib.h>
//#include <algorithm>
//#include <ctime>
//#include <iomanip>
//#include "Levenshtein.h"
//using namespace std;
//int main()
//{
//		setlocale(LC_ALL, "rus");
//		char s1[300];
//		char s2[250];
//		char alphabet[53] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghjklmnoprqrstuvwxyz";
//		srand(time(NULL));
//		for (int n = 0; n < 300; ++n)
//		{
//			s1[n] = alphabet[rand() % 52];
//		}
//		for (int n = 0; n < 300; ++n)
//		{
//			cout << s1[n];
//		}
//		for (int n = 0; n < 250; ++n)
//		{
//			s2[n] = alphabet[rand() % 52];
//		}
//		clock_t t1 = 0, t2 = 0, t3, t4;
//		char x[] = "abcdefghklmnoxm", y[] = "xyabcdefghomnkm";
//		int lx = sizeof(s1) - 1, ly = sizeof(s2) - 1;
//		std::cout << std::endl;
//		std::cout << std::endl << "-- расстояние Левенштейна -----" << std::endl;
//		std::cout << std::endl << "--длина --- рекурсия -- дин.програм. ---"
//			<< std::endl;
//		for (int i = 30; i < std::min(lx, ly); i++)
//		{
//			t1 = clock(); levenshtein_r(i, s1, i - 5, s2); t2 = clock();
//			t3 = clock(); levenshtein(i, s1, i - 5, s2); t4 = clock();
//			std::cout << std::right << std::setw(2) << i - 5 << "/" << std::setw(2) << i
//				<< " " << std::left << std::setw(10) << (t2 - t1) 
//				<< " " << std::setw(10) << (t4 - t3) << std::endl;
//		}
//		system("pause");
//	return 0;
//}
//
//
#include "stdafx.h"
#include <cmath>
#include <ctime>
#include <memory.h>
#include <iostream>
#include "MultiMatrix.h"   // умножение матриц 

#define N 6
int main()
{

	int Mc[N + 1] = { 8,11,19,22,29,39,50 }, Ms[N][N], r = 0, rd = 0;
	clock_t t1 = 0, t2 = 0, t3, t4;
	memset(Ms, 0, sizeof(int)*N*N);
	t1 = clock();
	r = OptimalM(1, N, N, Mc, OPTIMALM_PARM(Ms));
	t2 = clock();
	setlocale(LC_ALL, "rus");
	std::cout << std::endl;
	std::cout << std::endl << "-- расстановка скобок (рекурсивное решение) "
		<< std::endl;
	std::cout << "Длина рекурсии: " << (t2 -t1) << std::endl;
	std::cout << std::endl << "размерности матриц: ";
	for (int i = 1; i <= N; i++) std::cout << "(" << Mc[i - 1] << "," << Mc[i] << ") ";
	std::cout << std::endl << "минимальное количество операций умножения: " << r;
	std::cout << std::endl << std::endl << "матрица S" << std::endl;
	for (int i = 0; i < N; i++)
	{
		std::cout << std::endl;
		for (int j = 0; j < N; j++)  std::cout << Ms[i][j] << "  ";
	}
	std::cout << std::endl;
	std::cout << std::endl;
	memset(Ms, 0, sizeof(int)*N*N);
	t3 = clock();
	rd = OptimalMD(N, Mc, OPTIMALM_PARM(Ms));
	t4 = clock();
	std::cout << "Длина ДП: " << (t4 - t3) << std::endl;
	std::cout << std::endl
		<< "-- расстановка скобок (динамичеcкое программирование) " << std::endl;
	std::cout << std::endl << "размерности матриц: ";
	for (int i = 1; i <= N; i++)
		std::cout << "(" << Mc[i - 1] << "," << Mc[i] << ") ";
	std::cout << std::endl << "минимальное количество операций умножения: "
		<< rd;
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
