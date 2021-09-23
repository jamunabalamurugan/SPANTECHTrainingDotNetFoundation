using System;
using System.Collections.Generic;
using System.Text;

namespace MyFirstAssignment
{
	class AssignmentOperator
	{
		public static void Main()
		{
			int firstNumber, secondNumber;
			// Assigning a constant to variable
			firstNumber = 10;
			Console.WriteLine("First Number = {0}", firstNumber);

			// Assigning a variable to another variable
			secondNumber = firstNumber;
			Console.WriteLine("Second Number = {0}", secondNumber);
			Console.ReadKey();
		}
	}
}
