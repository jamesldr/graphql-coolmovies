import 'package:coolmovies/core/inject/app_injectors.dart';
import 'package:coolmovies/core/shared/base_state.dart';
import 'package:coolmovies/modules/home/domain/entities/movie.dart';
import 'package:coolmovies/modules/home/view/bloc/get_movie_list_bloc.dart';
import 'package:coolmovies/modules/home/view/widgets/movie_homepage_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GetMovieListBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = AppInjector().homeBloc;
    bloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cool Movies'),
        centerTitle: true,
      ),
      body: Center(
        child: BlocBuilder<GetMovieListBloc, BaseState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is LoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              );
            }
            if (state is ErrorState) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(state.message),
                ),
              );
            }
            if (state is SuccessState<List<Movie>>) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8.0),
                      itemCount: state.data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              // Modular.to.pushNamed(
                              //   HomeRoutes.movieDetailsRoute,
                              //   arguments: {'movie': state.data[index]},
                              // );
                            },
                            child: MovieHomepageCard(
                              movie: state.data[index],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            }
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('There is no movies in the database'),
              ),
            );
          },
        ),
      ),
    );
  }
}
