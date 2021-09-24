using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Csharpbasics
{
    class Program
    {
        static int no;
        public static void displayMenu()
        {
            Console.WriteLine("\n\n\n");
            Console.WriteLine("\t\t************ APPLICATION MENU ************");
            Console.WriteLine("\n");
            Console.WriteLine("\t\t\t1. Weekday \n\t\t\t2. Display Max\n\t\t\t3. Even or Odd\n\t\t\t4. Leap Year\n\t\t\t5.Fibonacci");
            Console.WriteLine("\n");
            Console.WriteLine("\t\t*******************************************");

        }
        public static void acceptData() { 
        Console.WriteLine("\n\t\tPlease enter the application number for the details:");
            
            no = Convert.ToInt32(Console.ReadLine());
            switch (no)
            {
                case 1:
                    switchweekday();
                    break;
                case 2: DisplayaMaxNum();
                    break;
                case 3:CheckEvenOdd();
                    break;
                case 4: LeapYearCheck();
                    break;
                case 5:FibSeries();
                    break;
                default: Console.WriteLine("Not a valid menu number");
                    break;

            }
        }

        public static bool switchweekday()
        {
            int num;
            Console.WriteLine("Enter a number");
            num = Convert.ToInt32(Console.ReadLine());

            switch (num)
            {
                case 1:
                    Console.WriteLine("Monday");
                    break;
                case 2:
                    Console.WriteLine("Tuesday");
                    break;
                case 3:
                    Console.WriteLine("Wednesday");
                    break;
                case 4:
                    Console.WriteLine("Thursday");
                    break;
                case 5:
                    Console.WriteLine("Friday");
                    break;
                case 6:
                    Console.WriteLine("Saturday");
                    break;
                case 7:
                    Console.WriteLine("Sunday");
                    break;
                case 0:
                    return true;
                default:
                    Console.WriteLine("Invalid Number");
                    break;
            }
            return false;
        }

        public static void DisplayaMaxNum()
        {
            int ctr, nNum1, max = 0;
            Console.WriteLine("Enter the numbers");
            for (ctr = 0; ctr <= 9; ctr++)
            {
                nNum1 = Convert.ToInt32(Console.ReadLine());
                if (nNum1 > max)
                {
                    max = nNum1;
                }

            }
            Console.WriteLine("The largest number is :" + max);
        }

        public static void CheckEvenOdd()
        {
            int Number;
            Console.WriteLine("Enter the number to be checked as Even or Odd");
            Number = Convert.ToInt32(Console.ReadLine());

            if (Number % 2 == 0)//25%2==1
            {
                Console.WriteLine("The number you have entered is an Even number");
            }
            else
            {
                Console.WriteLine("The number you have entered is an Odd number");
            }
        }

        public static void LeapYearCheck()
        {
            int nYear;
            Console.WriteLine("Please enter the year");
            nYear = Convert.ToInt32(Console.ReadLine());
            //2000 2004 2008 2012 2016 2020 2024 2028 2032 2036 2040..... 2100/4=525 even though it is divisible its not a leap year.....but 2400 is a leap year)

            //Y2K problem  - Sep11 2001
            //Y2036 problem
            //ATM Cash dispersal

            //ATM in India - 1995

            //IT in Banks,Insurance,Shares,Investments
            //IT in Health - Johnson n Johnson

            if (nYear % 400 == 0 || (nYear % 100 != 0 && nYear % 4 == 0))

            {
                Console.WriteLine("This is a leap year");
            }
            else
            {
                Console.WriteLine("This is not a leap year");
            }
        }

        public static void FibSeries()
        {
            int number1;
            int number2;
          


            number1 = number2 = 1;
            Console.WriteLine("{0}", number1);
            while (number2 < 200)
            {
                Console.WriteLine(number2);
                number2 += number1;// or number2=number2+number1; Binary operator  1,1,2,5,8,13,21,34
                number1 = number2 - number1;
            }
        }

        public static void IncrementEg()
        {
            int i = 0;
            int j = i + 1; //j=1 , i=0
         //   Console.WriteLine("Plus operator: i is {0} and j is {1}",i,j);
            j = i++; //j=0, i=1 post increment 
        //    Console.WriteLine("Post Increment: i is {0} and j is {1}", i, j);
            j = ++i; //j=2,i=2 pre increment
         //   Console.WriteLine("Pre Increment :i is {0} and j is {1}", i, j);
        }
        static void Main(string[] args)
        {
            bool result = true;
            do
            {
                displayMenu();
                acceptData();
            } while (true); 
           

            Console.ReadKey();
        }
    }


}
