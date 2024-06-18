import 'dart:convert';

import 'package:dukaanx/constraints/error_handling.dart';
import 'package:dukaanx/constraints/global_variables.dart';
import 'package:dukaanx/constraints/utils.dart';
import 'package:dukaanx/models/product.dart';
import 'package:dukaanx/models/user.dart';
import 'package:dukaanx/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailService {
  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    try {
      http.Response res = await http.post(
        Uri.parse("$uri/api/add-to-cart"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
        }),
      );
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            User user =
                userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
            userProvider.setUserFromModel(user);
          },
        );
      }
    } catch (e) {
      if(context.mounted){
        showSnackBar(context, e.toString());
      }
      
    }
  }

  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    try {
      http.Response res = await http.post(
        Uri.parse("$uri/api/rate-product"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
          'rating': rating,
        }),
      );
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {},
        );
      }
    } catch (e) {
      if(context.mounted){
        showSnackBar(context, e.toString());
      }
      
    }
  }
}
