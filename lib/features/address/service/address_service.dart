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

class AddressService {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/save-user-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'address': address,
        }),
      );

      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              User user = userProvider.user.copyWith(
                address: jsonDecode(res.body)['address'],
              );
              userProvider.setUserFromModel(user);
            });
      }
    } catch (e) {
      if(context.mounted){
        showSnackBar(context, e.toString());
      }
      
    }
  }

  // get all the order
  void placeOrder({
    required BuildContext context,
    required String address,
    required double totalSum,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(Uri.parse('$uri/api/order'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'cart': userProvider.user.cart,
            'address': address,
            'totalPrice': totalSum,
          }));

      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              showSnackBar(context, 'Your order has been placed!');
              User user = userProvider.user.copyWith(
                cart: [],
              );
              userProvider.setUserFromModel(user);
            });
      }
    } catch (e) {
      if(context.mounted){
        showSnackBar(context, e.toString());
      }
      
    }
  }

  // delete product

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      if(context.mounted){
          httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              onSuccess();
            },
          );
      }
      
    } catch (e) {
      if(context.mounted){
        showSnackBar(context, e.toString());
      }
      
    }
  }
}
