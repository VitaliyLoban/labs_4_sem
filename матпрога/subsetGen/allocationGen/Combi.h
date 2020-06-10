#pragma once 
#include "Combi1.h"
#include "Combi2.h"

namespace combi
{
	struct  accomodation  // ��������� ���������� 
	{
		short  n,      // ���������� ��������� ��������� ���������  
			m,      // ���������� ��������� � ���������� 
			*sset;      // ������ ������� �������� ����������  
		combi1::xcombination  *cgen;   // ��������� �� ��������� ���������
		combi2::permutation *pgen;   // ��������� �� ��������� ������������
		accomodation(short n = 1, short m = 1);  // �����������  
		void reset();     // �������� ���������, ������ ������� 
		short getfirst();     // ������������ ������ ������ ��������   
		short getnext();      // ������������ ��������� ������ ��������  
		short ntx(short i);   // �������� i-� ������� ������� ��������  
		unsigned __int64 na;  // ����� ���������� 0, ..., count()-1 
		unsigned __int64 count() const;  // ����� ���������� ���������� 
	};
}


