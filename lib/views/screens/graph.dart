import 'package:flutter/material.dart';
import 'package:instagram_aa/views/widgets/seedling_chart.dart';

class Graph extends StatefulWidget {
  const Graph({super.key});

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Graph from Gabby Backend',
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 400,
            child: SeedlingChart(),
          )
        ],
      ),
    );
  }
}
