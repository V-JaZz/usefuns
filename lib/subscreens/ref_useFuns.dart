import 'package:flutter/material.dart';

class UseFunds extends StatefulWidget {
  const UseFunds({super.key});

  @override
  State<UseFunds> createState() => _RefundState();
}

class _RefundState extends State<UseFunds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 67,
        backgroundColor: const Color(0xff9E26BC).withOpacity(0.2),
        automaticallyImplyLeading: true,
        title: const Center(
          child: Text('UseFuns'),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(40.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('UseFuns'),
                Text(
                    'Welcome to the Usefuns. You are reading the terms of service, Which govern the relationshipand serve as an agreement between You and us and set forth the terms and conditions by \nWhich you may access and use the Platform \nand our related Websites, Services, application\nProducts and content. Our and  services Provide\nFor private, Non Commercial use. For Purposes\nof these Terms,”you” and “Your” means you as \nthe Use of the services.\nThe terms form a legally binding agreement \nbetween You and us, Please take the time yo\nream them carefully. \nYou Must be at least 188 Years of age to create an account on usefuns and use the service.By creating an account and Using the service, You representand warrant that:You can from a binding Contract with Usefuns.You are not a person who is barred from using the service under the laws of the United states or any other applicable Jurisdiction meaning That you do\nnot appear On the U.S. Treasury Department’s \nlist of specially Designated Nationalsor face any \nother Similar Prohibition.\nYou will Comply With this agreement an all\napplicable local, state, national and international\nlaws, rules and regulations\nBy accesing or using our services, You confirm \nthat you froma binding Contract with Usefuns\nthat you accpect these Terms an dthat you agree\nto comply with them. Your access to and use of \nOur services is also subject to our privacy Policy\nand community Guidelines. The terms of which can\nbe found directly on the platform, on where the \nplatform is made avaliable for download, on your\nmobile device’s applicable app store, and are\nincorporated herein by reference. By using the \nServices, You Consent to the terms of the Privacy Policy.\n\nIf you access or use the services From Within a\njurisdivtion for which there are separate \nSuppletental terms applicable to users in each \njurisdiction from which you access or use use the \nservices ,and the rest of theseTerms you must\nnot accesss or use our services.\nIf you are accessing or using the services on\nbehalf of a business or wntity, then You and\nYour includes you  and that business or entity,\nYou  represent and Warrant of the business or\nentity is legally and financially responsible for\nThe  access or use of the services as well as \nfor the access or use of your account by others\naffiliated with our entity, Including any \nemployees, Agents or contractors.\nYou must Print off or Save a local copy of the \nTerms pf your records.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
