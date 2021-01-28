
/*class OurReview extends StatefulWidget {
  final CurrentGroupState currentGroupState;
  OurReview(
  {this.currentGroupState,}
      );
  @override
  _OurReviewState createState() => _OurReviewState();
}

class _OurReviewState extends State<OurReview> {
  int _dropdown;
  TextEditingController _reviewController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[BackButton(),],
            ),
          ),
          Spacer(),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: OurContener(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Rating 1-10:"),
                      DropdownButton<int>(
                        value: _dropdown,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
                        underline: Container(color: Theme.of(context).canvasColor,height: 2,),
                        onChanged: (int newValue){
                          setState(() {
                            _dropdown=newValue;
                          });
                        },
                        items: <int>[1,2,3,4,5,6,7,8,9,10].map<DropdownMenuItem<int>>((int value){
                          return DropdownMenuItem<int>(child: Text(value.toString()),
                            value: value,);
                        }
                        ).toList(),

                      )

                    ],
                  ),
                  TextFormField(
                    controller: _reviewController,
                    maxLines: 7,
                    decoration: InputDecoration(prefixIcon: Icon(Icons.rate_review),
                        hintText: " Add a Review"
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 95),
                    child: Text('Add Review',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15.0,
                    ),
                    ),
                  ),
                    onPressed: (){
                    String uid=Provider.of<CurrentState>(context,listen: false).getCurrentUser.uid;
                    widget.currentGroupState.finishedBook(uid, _dropdown, _reviewController.text);
                    Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }
}*/
