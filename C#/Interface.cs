using System;

namespace _03
{
    class Program
    {
        static void Main(string[] args)
        {
            Lamborgini lamborgini = new Lamborgini();
            lamborgini.Color = "Blue";
            lamborgini.Speed = 120;
            lamborgini.MotorHorsePower = 50;
            lamborgini.DorrNumber = 5;
            Pride pride = new Pride();
            pride.Color = "Red";
            pride.Speed = 5;
            pride.MotorHorsePower = 1;
            pride.DorrNumber = 4;
            BMW bmw = new BMW();
            bmw.Color = "Yellow";
            bmw.Speed = 110;
            bmw.MotorHorsePower = 45;
            bmw.DorrNumber = 2;

            Console.WriteLine("-----Lamborgini-----");
            Console.WriteLine("Color: " + lamborgini.Color);
            Console.WriteLine("speed: " + lamborgini.Speed);
            Console.WriteLine("Motor Horse Power: " + lamborgini.MotorHorsePower);
            Console.WriteLine("Door Number: " + lamborgini.DorrNumber);
            Console.WriteLine("--------------------");
            Console.WriteLine("");
            Console.WriteLine("--------pride-------");
            Console.WriteLine("Color: " + pride.Color);
            Console.WriteLine("speed: " + pride.Speed);
            Console.WriteLine("Motor Horse Power: " + pride.MotorHorsePower);
            Console.WriteLine("Door Number: " + pride.DorrNumber);
            Console.WriteLine("--------------------");
            Console.WriteLine("");
            Console.WriteLine("--------BMW---------");
            Console.WriteLine("Color: " + bmw.Color);
            Console.WriteLine("speed: " + bmw.Speed);
            Console.WriteLine("Motor Horse Power: " + bmw.MotorHorsePower);
            Console.WriteLine("Door Number: " + bmw.DorrNumber);
            Console.WriteLine("--------------------");


        }
    }

    interface ICar
    {
        int Speed { get; set; }
        int MotorHorsePower { get; set; }
        string Color { get; set; }
        int DorrNumber { get; set; }

    }

    class Lamborgini : ICar
    {
        public int Speed { get; set; }
        public int MotorHorsePower { get; set; }
        public string Color { get; set; }
        public int DorrNumber { get; set; }
    }
    class BMW : ICar
    {
        public int Speed
        { get; set; }
        public int MotorHorsePower
        { get; set; }
        public string Color
        { get; set; }
        public int DorrNumber
        { get; set; }
    }
    class Pride : ICar
    {
        public int Speed { get; set; }
        public int MotorHorsePower { get; set; }
        public string Color { get; set; }
        public int DorrNumber { get; set; }
    }

}
