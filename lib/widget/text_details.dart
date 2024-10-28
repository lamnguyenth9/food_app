import 'package:flutter/material.dart';
import 'package:food_delivery/utils/app_color.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widget/small_text.dart';

class TextDetails extends StatefulWidget {
 final  String text;
  const TextDetails({super.key, required this.text});

  @override
  State<TextDetails> createState() => _TextDetailsState();
}

class _TextDetailsState extends State<TextDetails> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText=true ;
  double textHeight=Dimension.screenHeight/5.63;
  @override
  void initState() {
    if(widget.text.length>textHeight){
      firstHalf=widget.text.substring(0,textHeight.toInt());
      secondHalf=widget.text.substring(textHeight.toInt()+1,widget.text.length);
    }else{
      firstHalf=widget.text;
      secondHalf="";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?
      SmallText(text: firstHalf)
      :Column(
        children: [
          SmallText(text: hiddenText?(firstHalf+"..."):(firstHalf+secondHalf),size: Dimension.font16,color: AppColor.paraColor,height: 1.8,),
          InkWell(
            onTap: (){
              setState(() {
                hiddenText=!hiddenText;
              });
            },
            child: Row(
              children: [
                SmallText(text:hiddenText? "show more":"Hidden",color: AppColor.mainColor,),
                Icon(
                  hiddenText?
                  Icons.arrow_drop_down
                  : Icons.arrow_drop_up
                  ,color: AppColor.mainColor,)
              ],
            ),
          )
        ],
      ),
    );
  }
}