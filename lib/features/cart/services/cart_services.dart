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

class CartServices {
  void removeFromCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/remove-from-cart/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              User user = userProvider.user
                  .copyWith(cart: jsonDecode(res.body)['cart']);
              userProvider.setUserFromModel(user);
            });
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  // remove every thing

  // void clearCart({
  //   required BuildContext context,
  // }) async {
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);
  //   try {
  //     http.Response res = await http.post(
  //       Uri.parse('$uri/api/clear-cart'),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'x-auth-token': userProvider.user.token,
  //       },
  //     );
  //     if (context.mounted) {
  //       httpErrorHandle(
  //           response: res,
  //           context: context,
  //           onSuccess: () {
  //             User user = userProvider.user
  //                 .copyWith(cart: jsonDecode(res.body)['cart']);
  //             userProvider.setUserFromModel(user);
  //           });
  //     }
  //   } catch (e) {
  //     if (context.mounted) {
  //       showSnackBar(context, e.toString());
  //     }
  //   }
  // }
}
