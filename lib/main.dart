import 'package:flutter/material.dart';
import 'package:state_management_library/statemanagemt_library/simple_state.dart';

// Counter App which uses the SimpleState library
void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterProvider(
        child: const CounterScreen(),
      ),
    );
  }
}

// CounterProvider to provide SimpleState<int> to the widget tree
class CounterProvider extends InheritedNotifier<SimpleState<int>> {
  CounterProvider({super.key, required super.child})
      : super(
          notifier: SimpleState<int>(0),
        );

  static SimpleState<int> of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<CounterProvider>();
    //code to assert an error when CounterProvider is not found
    assert(provider != null, 'No CounterProvider found in context');
    return provider!.notifier!;
  }
}

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counterState = CounterProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Counter App'))),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: ValueListenableBuilder<int>(
                valueListenable: counterState,
                builder: (context, count, child) {
                  return Text(
                    'Count: $count',
                    style: const TextStyle(fontSize: 32),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  onPressed: () => counterState.state++,
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: () => counterState.state--,
                  child: const Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: () => counterState.reset(),
                  child: const Text("reset"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
