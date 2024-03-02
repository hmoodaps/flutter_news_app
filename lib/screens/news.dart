import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class News extends StatelessWidget {
  WebViewController controller ;
  News(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<CubitClass, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        CubitClass cubitClass = CubitClass.get(context);
        List<dynamic>? list = cubitClass.myBusiness;
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  )),

            ),
            body: WebViewWidget(controller: controller));
      },
    );
  }
}
