import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intv_zatiq/presentation/blocs/home_bloc.dart';
import 'package:intv_zatiq/presentation/blocs/home_state.dart';

import '../blocs/home_event.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  var scrollController = ScrollController();
  int pageNo=1;
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeGetDataEvent(pageNo));
  }

  @override
  Widget build(BuildContext context) {

    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.position.pixels){
        pageNo=pageNo+1;
        context.read<HomeBloc>().add(HomeGetDataLazyEvent(pageNo));
      }
    });
    
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
          controller: scrollController,
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
                  onChanged: (v) {
                    _searchData(v);
                  },
                ),
              ),


              BlocBuilder<HomeBloc, HomeState>(
                builder: (_, state) {
                  if (state is HomeDataLoadState) {
                    if (state.isLoadingApi) {
                      return const Card(
                        child: SizedBox(
                          height: 100,
                          child: Center(child: Text('API Loading...')),
                        ),
                      );
                    } else if (state.apiError != null) {
                      return Card(
                        child: SizedBox(
                          height: 100,
                          child: Center(child: Text('${state.apiError}')),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.productList?.length ?? 0,
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        itemBuilder: (context, i) {
                          final d = state.productList![i];

                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 3,
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(12),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: d.img ?? '',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    width: 60,
                                    height: 60,
                                    color: Colors.grey[300],
                                    child: Icon(Icons.image, color: Colors.grey),
                                  ),
                                  errorWidget: (context, url, error) => Container(
                                    width: 60,
                                    height: 60,
                                    color: Colors.grey[300],
                                    child: Icon(Icons.broken_image, color: Colors.red),
                                  ),
                                ),
                              ),
                              title: Text(d.name ?? 'No Name',
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (d.categoryName!= null && d.categoryName!.isNotEmpty)
                                    Text(
                                      d.categoryName!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Price: \$${d.buyingPrice ?? 'N/A'}",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }
                  return const SizedBox.shrink();
                },
              ),


              BlocBuilder<HomeBloc, HomeState>(
                builder: (_, state) {
                  if (state is HomeDataLoadState) {
                    if (state.lazyLoadingApi) {
                      return Card(child: SizedBox(height: 200, child: Center(child: Text('Loading more...'))));
                    }else{
                      return Container();
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
    context.read<HomeBloc>().add(HomeGetDataEvent(1));
  }

  void _searchData(String v) async{
    context.read<HomeBloc>().add(HomeSearchDataEvent(v));
  }
}
