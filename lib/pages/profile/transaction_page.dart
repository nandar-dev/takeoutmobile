import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:takeout/models/transaction_model.dart';
import 'package:takeout/widgets/appbar_widget.dart';
import 'package:takeout/widgets/cards/transaction_card.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  final List<TransactionModel> _transactions = [];
  List<TransactionModel> _dummyTransactions = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _loadedCount = 0;
  final int _loadStep = 10;

  @override
  void initState() {
    super.initState();
    loadTransaction();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading) {
      _loadMore();
    }
  }

  Future<void> loadTransaction() async {
    final String jsonString = await rootBundle.loadString(
      'assets/data/transactions.json',
    );
    final List<dynamic> jsonResponse = json.decode(jsonString);

    setState(() {
      _dummyTransactions =
          jsonResponse.map((data) => TransactionModel.fromJson(data)).toList();
    });

    // Initial load
    _loadMore();
  }

  void _loadMore() {
    if (_loadedCount >= _dummyTransactions.length) return;

    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 1), () {
      final newItems =
          _dummyTransactions.skip(_loadedCount).take(_loadStep).toList();

      setState(() {
        _transactions.addAll(newItems);
        _loadedCount += _loadStep;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Transaction History'),
      // appBar: AppBar(
      //   title: const Text("Transaction History"),
      //   leading: const Icon(Icons.history),
      // ),
      body:
          _transactions.isEmpty && _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                controller: _scrollController,
                itemCount: _transactions.length + (_isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < _transactions.length) {
                    return TransactionCard(transaction: _transactions[index]);
                  } else {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
    );
  }
}
