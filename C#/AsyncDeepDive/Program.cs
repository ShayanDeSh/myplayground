using System;
using System.Runtime.CompilerServices;
using System.Threading.Tasks;

namespace AsyncLearning {
    class Program {
        static void Main(string[] args) {
            Console.WriteLine(FooAsync2().Result);
            Console.ReadLine();
        }

        static async Task<int> FooAsync() {
            return 42;
        }

        static Task<int> FooAsync2() {
            var stateMachine = new FooAsyncStateMachine();

            stateMachine.MethodBuilder = new AsyncTaskMethodBuilder<int>();

            stateMachine.MethodBuilder.Start(ref stateMachine);

            return stateMachine.MethodBuilder.Task;
        }

        struct FooAsyncStateMachine : IAsyncStateMachine {
            public AsyncTaskMethodBuilder<int> MethodBuilder;

            public void MoveNext() {
                // State machine
                MethodBuilder.SetResult(42);
            }

            public void SetStateMachine(IAsyncStateMachine stateMachine) {
                throw new NotImplementedException();
            }
        }
    }
}