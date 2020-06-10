using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace _1_proj
{
    class Program
    {
        static int c = 0;
        class Point
        {
            int X;
            int Y;
            int num;

            public Point(int x, int y, int num)
            {
                X = x;
                Y = y;
                this.num = num;
            }

            public int X1 { get => X; set => X = value; }
            public int Y1 { get => Y; set => Y = value; }
            public int Num { get => num; set => num = value; }
        }
        static void CheckDist(Point k1, Point k2)
        {
            Console.WriteLine($"Расстояние от точки №{k1.Num} до №{k2.Num}: {Math.Sqrt(Math.Pow((k2.X1 - k1.X1),2)  + Math.Pow((k2.Y1 - k1.Y1),2))}");
        }
        static void PrintPoint(Point t)
        {
            Console.WriteLine($"Координаты точки №{t.Num}: {t.X1} {t.Y1}");
        }
        static void PrintCount()
        {
            Console.WriteLine($"Кол-во обьектов: {c}");
        }
        static void Main(string[] args)
        {
            Point t1 = new Point(10,10,c++);

            Point t2 = new Point(20, 20, c++);
            Point t3 = new Point(30, 30, c++);
            Point t4 = new Point(40, 40, c++);
            PrintPoint(t1);
            CheckDist(t1, t4);
            PrintCount();
        }
    }
}
    