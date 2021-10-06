import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/no_internet.dart';
import 'connectivity_provider.dart';
import 'termservice.dart';

class TermService extends StatefulWidget {
  @override
  _TermServiceState createState() => _TermServiceState();
}

class _TermServiceState extends State<TermService> {
   @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    return  Consumer<ConnectivityProvider>(
      builder: (context, model, child) {
        if (model.isOnline != null) {
          return model.isOnline
              ? Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              scale: 5,
              image: AssetImage('assets/images/cut.png'),
              alignment: Alignment.bottomCenter),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade300, Colors.blueGrey.shade700])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Terms and Conditions",
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue.shade300,
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text:
                      '           This Policy (the "Policy") explains the way we treat information which is provided or collected in the Vhelp application (the "VHelp") service (the "Service") on which this Policy is posted.\n In addition the Policy also explains the information which is provided or collected in the course of using the applications of the Company which exist in the websites or platforms of other company.\n The Company is the controller of the information provided or collected in the websites on which this Policy is posted and in the course of using the applications of the Company which exist in the websites or platforms of other company.\n Through this Policy, the Company regards personal information of the users as important and inform them of the purpose and method of Company\'s using the personal information provided by the users and the measures taken by the Company for protection of those personal information.\n',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    ): NoInternet();
  }
    return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

