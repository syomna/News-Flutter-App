import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/modules/search%20screen/search_screen.dart';
import 'package:newsapp/shared/components/components.dart';
import 'package:newsapp/shared/cubit/cubit.dart';
import 'package:newsapp/shared/cubit/state.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'News App',
            ),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.search,
                  ),
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  }),
              IconButton(
                  icon: Icon(
                    Icons.brightness_4,
                  ),
                  onPressed: () {
                    cubit.changeTheme();
                  }),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.items,
            onTap: (value) => cubit.changeIndex(value),
          ),
          body: cubit.children[cubit.currentIndex],
        );
      },
    );
  }
}
