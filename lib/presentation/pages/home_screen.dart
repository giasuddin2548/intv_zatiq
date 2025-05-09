import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intv_zatiq/presentation/blocs/home_bloc.dart';
import 'package:intv_zatiq/presentation/blocs/home_state.dart';

import '../blocs/home_event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});




  @override
  Widget build(BuildContext context) {

    context.read<HomeBloc>().add(HomeGetDataEvent(1000));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text("Zatiq Api")),
      body: CustomRefreshIndicator(
        onRefresh: _onRefresh,
        builder: (context, child, controller) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              if (controller.isLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: CircularProgressIndicator(),
                ),
              AnimatedBuilder(
                animation: controller,
                builder: (context, _) => Transform.translate(
                  offset: Offset(0, controller.value * 100),
                  child: child,
                ),
              ),
            ],
          );
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search, size: 20),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (v){

                  },
                ),
              ),


              BlocBuilder<HomeBloc, HomeState>(
                builder: (_, state) {
                  if (state is HomeDataLoadState) {
                    if (state.isLoadingApi) {
                      return Card(
                          child: SizedBox(
                              height: 100,
                              child: Center(
                              child: Text('API Loading...'))
                          ));
                    } else if (state.apiError != null) {
                      return Card(
                          child: SizedBox(
                              height: 100,
                              child: Center(
                                  child: Text('${state.apiError}'))
                          ));
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.productList?.length??0,
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(16),
                          itemBuilder: (c, i){


                            var d= state.productList![i];
                            return ListTile(title: Text(d.name??''),);
                          });
                    }
                  }
                  return SizedBox.shrink();
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
