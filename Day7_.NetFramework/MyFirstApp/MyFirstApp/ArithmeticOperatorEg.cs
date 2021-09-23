using System;
using System.Collections.Generic;
using System.Text;

namespace MyFirstApp
{
	class ArithmeticOperator
	{
		public static void Main(string[] args)
		{
			double firstNumber = 14.40, secondNumber = 4.60, result;
			int num1 = 26, num2 = 4, rem;

			// Addition operator
			result = firstNumber + secondNumber;
			Console.WriteLine("{0} + {1} = {2}", firstNumber, secondNumber, result);

			// Subtraction operator
			result = firstNumber - secondNumber;
			Console.WriteLine("{0} - {1} = {2}", firstNumber, secondNumber, result);

			// Multiplication operator
			result = firstNumber * secondNumber;
			Console.WriteLine("{0} * {1} = {2}", firstNumber, secondNumber, result);

			// Division operator
			result = firstNumber / secondNumber;
			Console.WriteLine("{0} / {1} = {2}", firstNumber, secondNumber, result);

			// Modulo operator
			rem = num1 % num2;
			Console.WriteLine("{0} % {1} = {2}", num1, num2, rem);

			int firstNumber1, secondNumber1;
			// Assigning a constant to variable
			firstNumber1 = 10;
			Console.WriteLine("First Number = {0}", firstNumber1);

			// Assigning a variable to another variable
			secondNumber1 = firstNumber1;
			Console.WriteLine("Second Number = {0}", secondNumber1);
			Console.ReadKey();
		}
	}
}
