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
            await Task.Delay(5000);
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
            private int state;
            private TaskAwaiter awaiter;

            public void MoveNext() {
                // State machine
                if (state == 0) {
                    awaiter = Task.Delay(5000).GetAwaiter();
                    if (awaiter.IsCompleted) {
                        state = 1;
                        goto state1;
                    } else {
                        state = 1;
                        MethodBuilder.AwaitUnsafeOnCompleted(ref awaiter, ref this);
                    }

                    return;
                }

                state1:
                if (state == 1) {
                    awaiter.GetResult();
                    MethodBuilder.SetResult(42);
                    return;
                }
            }

            public void SetStateMachine(IAsyncStateMachine stateMachine) {
                MethodBuilder.SetStateMachine(stateMachine);
            }
        }
    }
}