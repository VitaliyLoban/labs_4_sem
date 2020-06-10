// --- main  
//    вычисление дистанции (расстояния) Левенштейна 
#include "stdafx.h"
#include <algorithm>
#include <iostream>
#include <ctime>
#include <iomanip>
#include "Auxil.h"
#include "Levenshtein.h"

char* generateString(int lenght) {
	char* str = new char[lenght];
	for (int i = 0; i < lenght; i++)
	{
		str[i] = (char)auxil::iget(97, 122);
	}
	str[lenght-1] = '\0';
	return str;
}

char* getString(char* str1, double k, int lenght2) {
	char* ret = new char[(int)(k*lenght2) + 1];
	for (int i = 0; i < (int)(k*lenght2)+1; i++)
	{
		ret[i] = str1[i];
	}
	ret[(int)(k*lenght2) + 1] = '\0';
	return ret;
}

int _tmain(int argc, _TCHAR* argv[])
{
	setlocale(LC_ALL, "rus");
	clock_t t1 = 0, t2 = 0, t3, t4;
	int lenght1 = 300, lenght2 = 250;
	char* s1 = new char[lenght1];
	char* s2 = new char[lenght2];
	char* s1_2, *s2_2;
	double k[] = {1 / 25.0, 1 / 20.0, 1 / 15.0, 1 / 10.0, 1 / 5.0, 1 / 2.0, 1.0};

	auxil::start();
	s1 = generateString(lenght1);
	s2 = generateString(lenght2);

	
	int  lx = lenght1 - 1, ly = lenght2 - 1;
	std::cout << std::endl;
	std::cout << std::endl << "-- расстояние Левенштейна -----" << std::endl;
	std::cout << std::endl << "S1 = " << s1 << std::endl << std::endl << "S2 = " << s2 << std::endl;

	for (int i = 0; i < 7; i++)
	{
		s1_2 = getString(s1, k[i], lenght2);
		s2_2 = getString(s2, k[i], lenght1);
		std::cout << std::endl << "S1_2 = " <<  s1_2 << std::endl << std::endl << "S2_2 = " << s2_2 << std::endl;
		std::cout << std::endl << "--длина --- рекурсия -- дин.програм. ---" << std::endl;
		t1 = clock();
		levenshtein_r(k[i]*lenght2, s1_2, k[i]*lenght1, s2_2);
		t2 = clock();
		t3 = clock();
		std::cout << "Расстояние: " << levenshtein(k[i] * lenght2, s1_2, k[i] * lenght1, s2_2) << std::endl;
		t4 = clock();
		std::cout << std::right << std::setw(2) << (int)(k[i] * lenght2) << "/" << std::setw(2) << (int)(k[i] * lenght1)
			<< "        " << std::left << std::setw(10) << (t2 - t1)
			<< "   " << std::setw(10) << (t4 - t3) << std::endl;
	}
	system("pause");
	return 0;
}

