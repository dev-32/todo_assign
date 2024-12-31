import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_assign/bloc/posts_bloc/post_cubit.dart';
import 'package:todo_assign/bloc/posts_bloc/post_state.dart';
import 'package:todo_assign/bloc/search_bloc/search_bloc.dart';
import 'package:todo_assign/bloc/search_bloc/search_state.dart';
import 'package:todo_assign/constant/colors.dart';
import 'package:todo_assign/constant/icons.dart';
import 'package:todo_assign/constant/text.dart';
import 'package:todo_assign/constant/text_styles.dart';
import 'package:todo_assign/models/posts_model.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<PostsDataModel> searchedPostResponseData = [];
  List<PostsDataModel> postResponeData = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: AppIcons.appBarIcon2,
          ),
        ],
        title: Text(
          AppText.postText,
          style: AppTextStyles.normalWhiteText,
        ),
      ),
      body: BlocBuilder<SearchBloc, SearchPostState>(
          builder: (context, searchState) {
        return BlocBuilder<PostCubit, PostState>(builder: (context, postState) {
          print(searchState);
          print(postState);
          if (searchState is SearchPostLoadedState) {
            searchedPostResponseData = searchState.dataModel;
          }
          if (postState is PostLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          } else if (postState is PostErrorState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(postState.message,
                      style:
                          AppTextStyles.mediumWhiteText.copyWith(fontSize: 17)),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<PostCubit>(context).loadPost();
                    },
                    child: Text(
                      AppText.retry,
                      style:
                          AppTextStyles.mediumWhiteText.copyWith(fontSize: 17),
                    )),
              ],
            );
          } else if (postState is PostLoadedState) {
            postResponeData = postState.dataModel;
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.darkGrayColor),
                  child: TextField(
                    style: AppTextStyles.mediumWhiteText,
                    controller: _searchController,
                    onChanged: (str) {
                      if (str.isEmpty) {
                        searchedPostResponseData.clear();
                      }
                      _searchController.text = str;
                      setState(() {});
                    },
                    keyboardType: TextInputType.number,
                    autofocus: false,
                    decoration: InputDecoration(
                        hintText: AppText.hintTextSearchBar,
                        hintStyle: AppTextStyles.normalGreyText,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 12),
                        suffixIcon: IconButton(
                            onPressed: () {
                              _searchController.text.isNotEmpty
                                  ? BlocProvider.of<SearchBloc>(context)
                                      .searchPosts(_searchController.text)
                                  : BlocProvider.of<PostCubit>(context)
                                      .loadPost();
                              FocusScope.of(context).unfocus();
                            },
                            icon: AppIcons.searchSendIcon),
                        prefixIcon: AppIcons.searchIcon,
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: searchState is SearchPostErrorState
                      ? Center(
                          child: Text(
                          AppText.notFound,
                          style: AppTextStyles.normalGreyText
                              .copyWith(fontSize: 15),
                        ))
                      : searchState is SearchPostLoadingState
                          ? Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            )
                          : ListView.builder(
                              itemCount: _searchController.text.isEmpty
                                  ? postResponeData.length
                                  : searchedPostResponseData.length,
                              itemBuilder: (context, index) {
                                PostsDataModel dataModel =
                                    _searchController.text.isEmpty
                                        ? postResponeData[index]
                                        : searchedPostResponseData[index];
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 12),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: AppColors.grayColor,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                    children: [
                                      Text(
                                        dataModel.id.toString(),
                                        style: AppTextStyles.mediumWhiteText,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: 250,
                                            child: AutoSizeText(
                                              dataModel.title,
                                              style:
                                                  AppTextStyles.boldWhiteText,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            width: 250,
                                            child: AutoSizeText(
                                              dataModel.body,
                                              style:
                                                  AppTextStyles.normalGreyText,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        dataModel.userId.toString(),
                                        style: AppTextStyles.mediumWhiteText,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                ),
              ],
            );
          } else {
            return Center(
              child: Text(AppText.underService,
                  style: AppTextStyles.mediumWhiteText.copyWith(fontSize: 17)),
            );
          }
        });
      }),
    );
  }
}
