import 'package:emart_app/consts/consts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool? ischeck = false;
  var controller = Get.put(AuthController());

  //text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              SizedBox(height: height * 0.1,),
              applogoWidget(),
              const SizedBox(height: 10,),
              const Text("Join To The $appname",style: TextStyle(fontSize: 18,fontFamily: bold,color: whiteColor),),
              const SizedBox(height: 10,),
              Container(
                width: width - 70,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                ),
                child: Obx(
                  ()=> Column(
                    children: [
                      customTextField(hint: namehint,title: name,obscure: false,controller: nameController),
                      customTextField(hint: emailhint,title: email,obscure: false,controller: emailController),
                      customTextField(hint: passwordhint,title: password,obscure: true,controller: passwordController),
                      customTextField(hint: passwordhint,title: retypepassword,obscure: true,controller: passwordRetypeController),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(onPressed: (){},child:const Text(forgetPass))),
                        const SizedBox(height: 5,),
                      Row(
                          children: [
                            Checkbox(
                              activeColor: redColor,
                              checkColor:whiteColor,
                              value: ischeck,
                              onChanged:(newValue){
                                setState(() {
                                  ischeck = newValue;
                                });
                              }
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              child: RichText(text:const TextSpan(
                                children: [
                                  TextSpan(text: "I Agree To The ",style: TextStyle(fontFamily: regular,color: fontGrey)),
                                  TextSpan(text: termAndCond,style: TextStyle(fontFamily: regular,color: redColor)),
                                  TextSpan(text: " & ",style: TextStyle(fontFamily: regular,color: fontGrey)),
                                  TextSpan(text: privancyPolicy,style: TextStyle(fontFamily: regular,color: redColor)),
                                ]
                              )),
                            ),
                          ],
                        ),
                      controller.isloading.value ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          ) : SizedBox(
                          width: width - 50,
                          child: ourButton(
                            title:signup,
                            color: ischeck == true ? redColor : lightGrey,
                            textcolor: whiteColor,
                            onPress: () async{
                              if (ischeck != false){
                                controller.isloading(true);
                                try {
                                  await controller.signupMethod(context: context,email: emailController.text,password: passwordController.text).then((value){
                                    return controller.storeUserData(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text
                                    );
                                  }).then((value){
                                    VxToast.show(context, msg: loggedin);
                                    Get.offAll(()=>const Home());
                                  });
                                } catch (e) {
                                  auth.signOut();
                                  VxToast.show(context, msg: e.toString());
                                  controller.isloading(false);
                                }
                              }
                          }),
                          ),
                      const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(alreadyHaveAccount,style: TextStyle(color: fontGrey)),
                              GestureDetector(
                                onTap: (){
                                  Get.back();
                                },
                                child: const Text(login,style: TextStyle(fontFamily: bold,color: redColor,))
                              ),
                            ]
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
  }
}