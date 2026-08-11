import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khazna/features/transactions/presentation/cubit/transaction/transaction_cubit.dart';
import 'package:khazna/features/transactions/presentation/pages/AddTransaction.dart';
import 'package:khazna/features/transactions/presentation/widgets/hide_on_scroll.dart';
import 'package:khazna/features/transactions/presentation/widgets/transaction_container.dart';
import 'package:khazna/features/transactions/presentation/widgets/wallet_header.dart';

class Home extends StatelessWidget {
  final ScrollController scrollController;
  const Home({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CustomScrollView(
          controller: scrollController,
          slivers: [
            const WalletHeader(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 140),
                child: const TransactionContainer(),
              ),
            ),
          ],
        ),
        Positioned(
          left: 16,
          bottom: 72,
          child: HideOnScroll(
            controller: scrollController,
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddTransaction()),
                );
                if (context.mounted) {
                  context.read<TransactionCubit>().getTransactions();
                }
              },
              backgroundColor: const Color(0xFF2ECC71),
              child: const Icon(Icons.add, color: Color(0xFFF7FDF9)),
            ),
          ),
        ),
      ],
    );
  }
}