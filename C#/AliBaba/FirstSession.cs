using System;
using System.Collections.Generic;

namespace cs
{
    class Program
    {
        static void Main(string[] args)
        {
            Car myCar = new Car("black", "BMW", "2016", "19000$");
            if (myCar.prime(17))
            {
                Console.WriteLine("Is prime");

            }
            else
            {
                Console.WriteLine("Is not prime");
            }

            Child child = new Child("shayan", 20);
            child.print("Hello World");

            int[] numbers = { 1, 2, 3, 4, 6 };
            Console.WriteLine("average is " + calculate(numbers, true));
            Console.WriteLine("sum is " + calculate(numbers));

            Console.WriteLine("Enter number of names:");
            var countStr = Console.ReadLine();
            var countNum = 0;
            List<String> names = new List<String>();
            try
            {
                countNum = Convert.ToInt32(countStr);
            }
            catch (System.Exception)
            {
                Console.WriteLine("Wrong Data Type, Expected Integer");
            }
            for (int i = 0; i < countNum; i++)
            {
                var input = Console.ReadLine();
                names.Add(input);
            }

            for (int i = countNum - 1; i >= 0; i--)
            {
                Console.WriteLine(names[i]);
            }

            Pride pride = new Pride();
            pride.speed = 125;
        }

        private static float calculate(int[] numbers, bool calc_average)
        {
            float average = 0;
            for (int i = 0; i < numbers.Length; i++)
            {
                average += numbers[i];
            }
            average = (float)average / numbers.Length;
            return average;
        }

        private static float calculate(int[] numbers)
        {
            float average = 0;
            for (int i = 0; i < numbers.Length; i++)
            {
                average += numbers[i];
            }
            return average;
        }

    }

    class Car
    {

        private string color;
        private string model;
        private string version;
        private string price;

        public Car(string color, string model, string version, string price)
        {
            this.color = color;
            this.model = model;
            this.version = version;
            this.price = price;
        }

        public bool prime(int number)
        {
            int max = 0, flag = 0;
            max = number / 2;
            for (int i = 2; i <= max; i++)
            {
                if (number % i == 0)
                {
                    flag = 1;
                    break;
                }
            }

            return flag == 0;

        }
    }


    public class Praent
    {
        private string name;
        private int age;

        public Praent(string name, int age)
        {
            this.name = name;
            this.age = age;
        }

        public void print(String log)
        {
            Console.WriteLine(log);
        }

    }

    public class Child : Praent
    {
        public Child(string name, int age) : base(name, age)
        {

        }



    }


    public class Pride
    {
        private int _speed;
        public int speed
        {
            get
            {
                return _speed;
            }
            set
            {
                if (value > 120)
                {
                    Console.WriteLine("Welcome To Heaven!!");
                }
                else
                {
                    _speed = value;
                }
            }
        }
    }


}
