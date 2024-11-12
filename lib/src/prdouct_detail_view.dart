import 'package:api_test/utils/custom_textfield_two.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import '../bloc/home_bloc/home_bloc.dart';

class ProductDetailView extends StatelessWidget {
  ProductDetailView({super.key});
  final TextEditingController price = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController desc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          body: SingleChildScrollView(
            child: state.productLoaad
                ? SkeletonLoader(
                    builder: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Container(
                          width: width * 0.8,
                          height: 400,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ]))
                : Container(
                    height: height,
                    color: const Color(0xFFada8ef),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: height * 0.87,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * 0.08,
                              ),
                              Stack(
                                children: [
                                  Container(
                                    height: 350,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: PageView.builder(
                                      itemCount: state.productApi.firstOrNull
                                          ?.images?.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.fill,
                                            imageUrl: state
                                                    .productApi
                                                    .firstOrNull
                                                    ?.images?[index] ??
                                                "",
                                            placeholder: (context, url) =>
                                                const CupertinoActivityIndicator(
                                                    radius: 15,
                                                    color: Colors.black),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    top: 20,
                                    left: 20,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.09),
                                              offset: const Offset(0, 0),
                                              spreadRadius: 2,
                                              blurRadius: 10)
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.arrow_back_ios,
                                          size: 17,
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 20,
                                    right: 20,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: IconButton(
                                        icon: const Icon(Icons.favorite_border),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '\$${state.productApi.firstOrNull?.price}',
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      state.productApi.firstOrNull?.title ?? "",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      state.productApi.firstOrNull
                                              ?.description ??
                                          "",
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.grey[300],
                                            child: const Text('J'),
                                          ),
                                          const SizedBox(width: 10),
                                          const Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Aghmashenebeli Ave 75',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text('1 item is in the way'),
                                              ],
                                            ),
                                          ),
                                          const Icon(Icons.chevron_right),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              isDismissible: true,
                              enableDrag: true,
                              backgroundColor: Colors.white,
                              isScrollControlled: true,
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16)),
                              ),
                              builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.all(20),
                                    height: height * 0.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          "Title",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        CustomTextfieldTwo(
                                          hintText: "Edit Title",
                                          controller: title,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "Description",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        CustomTextfieldTwo(
                                          hintText: "Edit Description",
                                          controller: desc,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "Price",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        CustomTextfieldTwo(
                                          hintText: "Edit Price",
                                          controller: price,
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            context.read<HomeBloc>().add(
                                                EditPrdouct(
                                                    context: context,
                                                    title: title.text,
                                                    desc: desc.text,
                                                    price: price.text,
                                                    id: state.productApi
                                                            .firstOrNull?.id
                                                            .toString() ??
                                                        ""));
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            height: 50,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "Save",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFFece5ef),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Edit",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
