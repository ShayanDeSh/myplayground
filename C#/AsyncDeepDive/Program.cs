using System;
using System.Runtime.CompilerServices;

namespace AsyncLearning {
    class Program {
        static void Main(string[] args) {
            FooAsync2();
            Console.ReadLine();
        }

        static async void FooAsync() {
        }

        static void FooAsync2() {
            var stateMachine = new FooAsyncStateMachine();

            stateMachine.MethodBuilder = new AsyncVoidMethodBuilder();
            
            stateMachine.MethodBuilder.Start(ref stateMachine);
        }

        struct FooAsyncStateMachine : IAsyncStateMachine {
            public AsyncVoidMethodBuilder MethodBuilder;

            public void MoveNext() {
                // State machine
                MethodBuilder.SetResult();
            }

            public void SetStateMachine(IAsyncStateMachine stateMachine) {
                throw new NotImplementedException();
            }
        }
    }
}