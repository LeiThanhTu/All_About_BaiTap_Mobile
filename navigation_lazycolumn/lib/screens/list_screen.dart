import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ListScreen extends StatelessWidget {
  final List<String> quotes = List.generate(
    1000000,
    (index) => "${index + 1} | The only way to do great work is to love what you do.",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LazyColumn"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView.builder(
        itemCount: quotes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(quotes[index]),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => context.go('/detail', extra: quotes[index]),
          );
        },
      ),
    );
  }
}
