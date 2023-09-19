import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_counter_app/constants/enums.dart';
import 'package:flutter_bloc_counter_app/logic/cubit/counter_cubit.dart';
import 'package:flutter_bloc_counter_app/logic/cubit/internet_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title, required this.color});

  final String title;
  final Color color;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<InternetCubit, InternetState>(
                builder: (context, state) {
              if (state is InternetConnected &&
                  state.connectionType == ConnectionType.Wifi) {
                return const Text('Wi-fi');
              } else if (state is InternetConnected &&
                  state.connectionType == ConnectionType.Mobile) {
                return const Text('Mobile');
              } else if (state is InternetDisconnected) {
                return const Text('Offline');
              }
              return const CircularProgressIndicator();
            }),
            const SizedBox(height: 24),
            Builder(builder: (context) {
              final counterState = context.watch<CounterCubit>().state;
              final internetState = context.watch<InternetCubit>().state;

              if (internetState is InternetConnected &&
                  internetState.connectionType == ConnectionType.Wifi) {
                return Text(
                    'Counter: ${counterState.counterValue.toString()}, Internet: Wifi');
              } else if (internetState is InternetConnected &&
                  internetState.connectionType == ConnectionType.Mobile) {
                return Text(
                    'Counter: ${counterState.counterValue.toString()}, Internet: Mobile');
              } else {
                return Text(
                    'Counter: ${counterState.counterValue.toString()}, Internet: Offline');
              }
            }),
            const SizedBox(height: 24),
            const SizedBox(height: 24),
            Builder(builder: (context) {
              final counterValue = context
                  .select((CounterCubit cubit) => cubit.state.counterValue);
              return Text('Counter: $counterValue');
            }),
            const SizedBox(height: 24),
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocConsumer<CounterCubit, CounterState>(
              builder: (context, state) {
                if (state.counterValue < 0) {
                  return Text(
                    'Brr, negative ${state.counterValue.toString()}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else if (state.counterValue % 2 == 0) {
                  return Text(
                    'Even number: ${state.counterValue.toString()}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else if (state.counterValue == 5) {
                  return Text(
                    'Number ${state.counterValue.toString()}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }

                return Text(
                  state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
              listener: (context, state) {
                if (state.wasIncremented == true) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Incremented!'),
                    duration: Duration(milliseconds: 300),
                  ));
                }
                if (state.wasIncremented == false) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Decremented!'),
                    duration: Duration(milliseconds: 300),
                  ));
                }
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  tooltip: 'Increment',
                  heroTag: 'btnPlus',
                  child: const Icon(Icons.add),
                ),
                const SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  tooltip: 'Decrement',
                  heroTag: 'btnMinus',
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(widget.color)),
              child: const Text('Go to second screen'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/third');
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(widget.color)),
              child: const Text('Go to third screen'),
            ),
          ],
        ),
      ),
    );
  }
}
