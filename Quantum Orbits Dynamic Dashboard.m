(* ::Package:: *)

(************************************************************************)
(* This file was generated automatically by the Mathematica front end.  *)
(* It contains Initialization cells from a Notebook file, which         *)
(* typically will have the same name as this file except ending in      *)
(* ".nb" instead of ".m".                                               *)
(*                                                                      *)
(* This file is intended to be loaded into the Mathematica kernel using *)
(* the package loading commands Get or Needs.  Doing so is equivalent   *)
(* to using the Evaluate Initialization Cells menu command in the front *)
(* end.                                                                 *)
(*                                                                      *)
(* DO NOT EDIT THIS FILE.  This entire file is regenerated              *)
(* automatically each time the parent Notebook file is saved in the     *)
(* Mathematica front end.  Any changes you make to this file will be    *)
(* overwritten.                                                         *)
(************************************************************************)



Needs["EPToolbox`"]
NotebookEvaluate[
"/home/episanty/Work/CQD/Project/Scratch/functions 28.05 functions file v1.0.6.nb",
EvaluationElements->"InitializationCell"
];


(*stdpars={0.05,0.057,1.07};*)


(*ts[pp_,\[Kappa]_,\[Omega]_,F_,po_,py_]:=1/\[Omega]ArcSin[\[Omega]/Fpp+\[ImaginaryI] \[Omega]/FSqrt[\[Kappa]^2+po^2+py^2]]*)


(*t0[pp_,\[Kappa]_,\[Omega]_,F_,po_,py_]:=Re[ts[pp,\[Kappa],\[Omega],F,po,py]]
\[Tau][pp_,\[Kappa]_,\[Omega]_,F_,po_,py_]:=Im[ts[pp,\[Kappa],\[Omega],F,po,py]]*)


(*FullSimplify[Re[
\[ImaginaryI] Integrate[\[Kappa]^2/2+1/2(po^2+py^2)+1/2(pp-F/\[Omega]Sin[\[Omega] t])^2,{t,0,1/\[Omega]ArcSin[\[Omega]/F(pp+\[ImaginaryI] Sqrt[\[Kappa]^2+po^2+py^2])]}]/.{Sin[2u_]\[Rule]2Sin[u]Cos[u]}
]]*)
(*exponent[{po_,py_,pp_},{F_,\[Omega]_},\[Kappa]_]:=-(1/8) Im[1/\[Omega]^3(2 F \[Omega] (-4 pp+3 pp Sqrt[1+((-\[ImaginaryI] pp+Sqrt[po^2+py^2+\[Kappa]^2])^2 \[Omega]^2)/F^2]-\[ImaginaryI] Sqrt[po^2+py^2+\[Kappa]^2] Sqrt[1+((-\[ImaginaryI] pp+Sqrt[po^2+py^2+\[Kappa]^2])^2 \[Omega]^2)/F^2])+2 (F^2+2 (po^2+pp^2+py^2+\[Kappa]^2) \[Omega]^2) ArcSin[((pp+\[ImaginaryI] Sqrt[po^2+py^2+\[Kappa]^2]) \[Omega])/F])]*)


Options[timeContours]={ImageSize->{360,360}};
timeContours[r2function_,rules_,tss_,path_,range_:{{All,All},{All,All}},OptionsPattern[]]:=Show[{
RegionPlot[
Tooltip[Re[r2function[ret+I imt]]<0,DisplayForm[Row[{"Re(",Superscript["\!\(\*SubscriptBox[\(r\), \(cl\)]\)(t)","2"],")<0"}]]]
,{ret,
Evaluate[If[#===All,"t0"-10/.rules,#]&[range[[1,1]]]],
Evaluate[If[#===All,Re[Last[path]]+10/.rules,#]&[range[[1,2]]]]
},{imt,
Evaluate[If[#===All,-10,#]&[range[[2,1]]]],
Evaluate[If[#===All,Max[Im[tss]+10,15],#]&[range[[2,2]]]]
},AspectRatio->Automatic,AxesOrigin->{0,0},PlotRangePadding->0
,FrameLabel->{"Re(t)","Im(t)"}
,PlotLabel->"time contour"
,PlotStyle->GrayLevel[0.8]
,ImageSize->OptionValue[ImageSize]
],
Sequence@@Table[
ContourPlot[
Im[r2function[ret+I imt]]==0
,{ret,
Evaluate[If[#===All,"t0"-10/.rules,#]&[range[[1,1]]]],
Evaluate[If[#===All,Re[Last[path]]+10/.rules,#]&[range[[1,2]]]]
},{imt,
Evaluate[If[#===All,-10,#]&[range[[2,1]]]],
Evaluate[If[#===All,Max[Im[tss]+10,15],#]&[range[[2,2]]]]
},AspectRatio->Automatic,AxesOrigin->{0,0},PlotRangePadding->0
,ContourStyle->{Thick,selector/.{Less->Red,Greater->RGBColor[0,0.6,0]}}
,ContourLabels->{None,Tooltip[Null,
selector/.{Less->DisplayForm[Row[{"Branch cut.\nIm(",Superscript["\!\(\*SubscriptBox[\(r\), \(cl\)]\)(t)","2"],")=0,\nRe(",Superscript["\!\(\*SubscriptBox[\(r\), \(cl\)]\)(t)","2"],")<0"}]],Greater->DisplayForm[Row[{"Im(",Superscript["\!\(\*SubscriptBox[\(r\), \(cl\)]\)(t)","2"],")=0,\nRe(",Superscript["\!\(\*SubscriptBox[\(r\), \(cl\)]\)(t)","2"],")>0"}]]}
]&}
,RegionFunction->Function[{ret,imt},selector[Re[r2function[ret+I imt]],0]]
]
,{selector,{Greater,Less}}
]
}]


Options[timePathPlotter]={ImageSize->{360,360}};
timePathPlotter[rules_,t_,sman_,OptionsPattern[]]:=Show[{
ParametricPlot[
{Re[t[s]],Im[t[s]]}
,{s,0,1}
,Frame->True,Axes->False,AxesOrigin->{0,0}
,PlotRangePadding->2
]
,Graphics[{PointSize[Large],Purple,Tooltip[Point[{Re[#],Im[#]}&@Evaluate["ts"/.rules]],"\!\(\*SubscriptBox[\(t\), \(s\)]\)"]}]
,Graphics[{PointSize[Large],Gray,Tooltip[Point[{Re[#],Im[#]}&@Evaluate["t\[Kappa]"/.rules]],"\!\(\*SubscriptBox[\(t\), \(\[Kappa]\)]\)"]}]
,Graphics[{PointSize[Large],Green,Tooltip[Point[{Re[t[0]],Im[t[0]]}(*/.s\[Rule]0*)],"Contour start"]}]
,Graphics[{PointSize[Large],Red,Tooltip[Point[{Re[t[1]],Im[t[1]]}(*/.s\[Rule]1*)],"Contour end"]}]
,Graphics[{PointSize[Large],Blue,Tooltip[Point[{0,0}],"Time origin"]}]
,Graphics[{PointSize[Large],Black,Tooltip[Point[{Re[t[sman]],Im[t[sman]]}],"t(s)"]}]
}]


Options[trajectoryPlotter]={"PlotRange"->All};
trajectoryPlotter[trajectoryFunction_,label_,sman_,OptionsPattern[]]:=
Show[#,PlotRange->OptionValue["PlotRange"],PlotRangePadding->0.05Max[(#[[2]]-#[[1]]&)/@(PlotRange/. AbsoluteOptions[#,PlotRange])]]&@(*For better padding, as per mm.se:42495.*)
Show[
ParametricPlot[
{Re[trajectoryFunction[s]],Im[trajectoryFunction[s]]},{s,0,1}
,AspectRatio->Automatic
,PlotRange->Full
,Frame->True
,Axes->False
,AxesOrigin->{0,0}
,FrameLabel->{"Re("<>label<>")","Im("<>label<>")"}
,PlotLabel->label
,Evaluate@If[label=="\!\(\*SubscriptBox[\(r\), \(cl\)]\)(t\!\(\*SuperscriptBox[\()\), \(2\)]\)",Prolog->{
GrayLevel[0.8],Tooltip[Rectangle[{-1000,-1000},{0,1000}],DisplayForm[Row[{"Re(",Superscript["\!\(\*SubscriptBox[\(r\), \(cl\)]\)(t)","2"],")<0"}]]],
Red,Thick,Tooltip[Line[{{-1000,0},{0,0}}],DisplayForm[Row[{"Branch cut\n",Superscript["\!\(\*SubscriptBox[\(r\), \(cl\)]\)(t)","2"],")<0"}]]]
},##&[]
]
,ImageSize->{360,360}
]
,Graphics[{PointSize[Large],Green,Tooltip[Point[{Re[trajectoryFunction[0]],Im[trajectoryFunction[0]]}],"Contour start"]}]
,Graphics[{PointSize[Large],Red,Tooltip[Point[{Re[trajectoryFunction[1]],Im[trajectoryFunction[1]]}],"Contour end"]}]
,Graphics[{PointSize[Large],Blue,Tooltip[Point[{0,0}],"Origin"]}]
,Graphics[{PointSize[Large],Black,Tooltip[Point[{Re[trajectoryFunction[sman]],Im[trajectoryFunction[sman]]}],label]}]
]


Options[timeIntegrandPlotter]={ImageSize->{360,360}};
timeIntegrandPlotter[rer2function_,t_,OptionsPattern[]]:=ParametricPlot[{
Tooltip[{s,Re[-(rer2function[s])^(-1/2)D[t[ss],ss]/.{ss->s}]},"Re"],
Tooltip[{s,Im[-(rer2function[s])^(-1/2)D[t[ss],ss]/.{ss->s}]},"Im"],
Tooltip[{s,Abs[-(rer2function[s])^(-1/2)D[t[ss],ss]/.{ss->s}]},"Abs"]
},{s,0,1}
,PlotRange->{{0,1},Full}
,AspectRatio->1/3
(*,PlotPoints\[Rule]20*)
,Frame->True
,AxesStyle->Gray
,FrameLabel->{Style[ToString[s,TraditionalForm],Larger],""}
,PlotLabel->"Re, Im and Abs of \!\(\*FractionBox[\(-1\), SqrtBox[\(\*SubscriptBox[\(r\), \(cl\)] \*SuperscriptBox[\((t)\), \(2\)]\)]]\)\!\(\*FractionBox[\(dt\), \(ds\)]\) over the contour"
,ImageSize->OptionValue[ImageSize]
]


ionizationProbabilityColorFunction=(Blend[{RGBColor[0.4,0,0],Red,Orange,Yellow},#]&);


colourScale[{pomax_,ppmax_},{F_,\[Omega]_},\[Kappa]_]:=colourScale[{pomax,0,ppmax},{F,\[Omega]},\[Kappa]]=ContourPlot[
y,
{x,0,0.075},{y,0,1}
,AspectRatio->Automatic
,Contours->10^Range[Floor[Log[10,E^(2volkovExponent[{pomax,0,ppmax},{F,\[Omega],\[Kappa]}])/E^(2volkovExponent[{0,0,0},{F,\[Omega],\[Kappa]}])]],-0,0.1]
,PlotRangePadding->None
,FrameTicks->{{None,{10^Range[-1,0,0.1],ToString[#,TraditionalForm]&/@Evaluate[10^ToString/@Range[-1,0,0.1]/.{
\!\(\*SuperscriptBox[\(10\), \("\<0.\>"\)]\)->1}]}\[Transpose]},{None,None}}
,ContourLabels->None
,ColorFunction->ionizationProbabilityColorFunction
,ImageSize->{70,200}
]


colourScale[{1,1.5},{0.05,0.055},1.007]


(*ionizationProbabilityColours[{F_,\[Omega]_},\[Kappa]_]:=ionizationProbabilityColours[{F,\[Omega]},\[Kappa]]=Module[{ppmax=1.5,pomax=1,},
Rasterize[
(*Coloured regions are rasterized, and the contour lines, with their tooltips, are overlaid after that, as per mm.se/q/43152.*)
ContourPlot[
\[ExponentialE]^(2exponent[{ppo,0,ppp},{F,\[Omega]},\[Kappa]])/\[ExponentialE]^(2exponent[{0,0,0},{F,\[Omega]},\[Kappa]])
,{ppo,0,pomax},{ppp,0,ppmax}
,PlotRange\[Rule]Full
,AspectRatio\[Rule]Automatic
,PlotRangePadding\[Rule]None
,Contours\[Rule]10^Range[Floor[Log[10,\[ExponentialE]^(2exponent[{pomax,0,ppmax},{F,\[Omega]},\[Kappa]])/\[ExponentialE]^(2exponent[{0,0,0},{F,\[Omega]},\[Kappa]])]],-0,0.1]
,ContourStyle\[Rule]None
,ColorFunction\[Rule]colorfunction
,ImageSize\[Rule]{{360},{340}}
,FrameLabel\[Rule]{Text["|Subscript[p, \[Perpendicular]]|"],Text["Subscript[p, \[DoubleVerticalBar]]"]}
]
]
]*)


(*ionizationProbabilityContours[{F_,\[Omega]_},\[Kappa]_]:=ionizationProbabilityContours[{F,\[Omega]},\[Kappa]]=Module[{ppmax=1.5,pomax=1,
colorfunction=(Blend[{RGBColor[0.4,0,0],Red,Orange,Yellow},#]&)},
Show[
ContourPlot[
\[ExponentialE]^(2exponent[{ppo,0,ppp},{F,\[Omega]},\[Kappa]])/\[ExponentialE]^(2exponent[{0,0,0},{F,\[Omega]},\[Kappa]])
,{ppo,0,pomax},{ppp,0,ppmax}
,PlotRange\[Rule]Full
,Contours\[Rule]10^Range[Floor[Log[10,\[ExponentialE]^(2exponent[{pomax,0,ppmax},{F,\[Omega]},\[Kappa]])/\[ExponentialE]^(2exponent[{0,0,0},{F,\[Omega]},\[Kappa]])]],-0,1]
,ContourShading\[Rule]None
,ContourStyle\[Rule]{Black}
,PlotPoints\[Rule]20
,AspectRatio\[Rule]Automatic
,PlotRangePadding\[Rule]None
,ImageSize\[Rule]{{360},{340}}
,FrameLabel\[Rule]{Style[Text["|Subscript[p, \[Perpendicular]]|"],Opacity[0]],Style[Text["|Subscript[p, \[DoubleVerticalBar]]|"],Opacity[0]]}
,Frame\[Rule]True
,FrameStyle\[Rule]Directive[Opacity[0]]
,FrameTicksStyle\[Rule]Directive[Opacity[0]]
],
ContourPlot[
\[ExponentialE]^(2exponent[{ppo,0,ppp},{F,\[Omega]},\[Kappa]])/\[ExponentialE]^(2exponent[{0,0,0},{F,\[Omega]},\[Kappa]])
,{ppo,0,pomax},{ppp,0,ppmax}
,PlotRange\[Rule]Full
,Contours\[Rule]10^Range[-2,0,0.1]
,ContourShading\[Rule]None
,ContourStyle\[Rule]{Thin}
,PlotPoints\[Rule]20
]
]
]*)


(*Row[{
Overlay[{
ionizationProbabilityColours[{0.05,0.055},1.007],
LocatorPane[
{0.2,.2},
ionizationProbabilityContours[{0.05,0.055},1.007]
,BaselinePosition\[Rule]Center
]
},All,2,Alignment\[Rule]Center],
colourScale[{1,0,1.5},{0.05,0.055},1.007]
}];*)


(*ionizationProbability[{po_,py_,pp_},{F_,\[Omega]_},\[Kappa]_,{pomax_,ppmax_}]:=Grid[{
{Text[
"Probability = "<>(If[#\[LessEqual]10^-2,
ToString[ScientificForm[#,2],TraditionalForm],
ToString[NumberForm[#,2]]
]&[\[ExponentialE]^(2exponent[{po,py,pp},{F,\[Omega]},\[Kappa]])/\[ExponentialE]^(2exponent[{0,0,0},{F,\[Omega]},\[Kappa]])])
]},
{
Overlay[{
ionizationProbabilityColours[{F,\[Omega]},\[Kappa]],
Show[
ionizationProbabilityContours[{F,\[Omega]},\[Kappa]],
Graphics[{PointSize[Large],RGBColor[0,0.7,0],    Point[{po,Abs@pp}]}]
]
},All,2,Alignment\[Rule]Center],
colourScale[{pomax,ppmax},{F,\[Omega]},\[Kappa]]
}
}]*)


ClearAll[ionizationProbabilityPlot]
ionizationProbabilityPlot[{F_,\[Omega]_,\[Kappa]_}]:=ionizationProbabilityPlot[{F,\[Omega],\[Kappa]},a]=Module[
{ppmax=1.5,pomax=1},
Show[
cleanContourPlot[ContourPlot[
E^(2volkovExponent[{ppo,0,ppp},{F,\[Omega],\[Kappa]}])/E^(2volkovExponent[{0,0,0},{F,\[Omega],\[Kappa]}])
,{ppo,0,pomax},{ppp,0,ppmax}
,PlotRange->Full
,Contours->10^Range[-2,0,0.1]
,ColorFunction->ionizationProbabilityColorFunction
,ContourStyle->None
,PlotPoints->20
,AspectRatio->Automatic
,PlotRangePadding->None
,ImageSize->{{360},{340}}
]],
ContourPlot[
E^(2volkovExponent[{ppo,0,ppp},{F,\[Omega],\[Kappa]}])/E^(2volkovExponent[{0,0,0},{F,\[Omega],\[Kappa]}])
,{ppo,0,pomax},{ppp,0,ppmax}
,PlotRange->Full
,Contours->10^Range[-2,0,0.1]
,ContourShading->None
,ContourStyle->{{Thickness[0.003],Black}}
,PlotPoints->20
],
(ContourPlot[
E^(2volkovExponent[{ppo,0,ppp},{F,\[Omega],\[Kappa]}])/E^(2volkovExponent[{0,0,0},{F,\[Omega],\[Kappa]}])
,{ppo,0,pomax},{ppp,0,ppmax}
,PlotRange->Full
,Contours->10^Range[Floor[Log[10,E^(2volkovExponent[{pomax,0,ppmax},{F,\[Omega],\[Kappa]}])/E^(2volkovExponent[{0,0,0},{F,\[Omega],\[Kappa]}])]],-0,1]
,ContourShading->None
,ContourStyle->{Black}
,PlotPoints->20
]/.{
Tooltip[expr_,tooltip_]:>Tooltip[expr,DisplayForm[SuperscriptBox[10,Log[10,tooltip]]]]
})
]
]
ionizationProbabilityPlot[stdpars]


(*ClearAll[rangeReset];*)
SetAttributes[rangeReset,HoldFirst]
rangeReset[range_,{label1_,label2_}]:=Row[{
Grid[{
{InputField[Dynamic[range[[1,1]]],FieldSize->3],"\[LessEqual]"<>label1<>"\[LessEqual]",InputField[Dynamic[range[[1,2]]],FieldSize->3]},
{InputField[Dynamic[range[[2,1]]],FieldSize->3],"\[LessEqual]"<>label2<>"\[LessEqual]",InputField[Dynamic[range[[2,2]]],FieldSize->3]}
}],
"  ",
Button["Reset",range={{All,All},{All,All}},ImageSize->Medium]
}]


SetAttributes[momentumPlaneControls,HoldAll];
momentumPlaneControls[{po_,py_,pp_},{F_,\[Omega]_,\[Kappa]_}]:=Grid[{
{Dynamic[Text[
"Probability = "<>(If[#<=10^-2,
ToString[ScientificForm[#,2],TraditionalForm],
ToString[NumberForm[#,2]]
]&[E^(2volkovExponent[{po,py,pp},{F,\[Omega],\[Kappa]}])/E^(2volkovExponent[{0,0,0},{F,\[Omega],\[Kappa]}])])
]]},
{
LocatorPane[
Dynamic[
{Abs[po],Abs[pp]},
((po=If[po!=0,Sign[po]#[[1]],#[[1]]]);(pp=If[pp!=0,Sign[pp]#[[2]],#[[2]]]);updateDefinitions[])&
],
ionizationProbabilityPlot[{F,\[Omega],\[Kappa]}]
],
colourScale[{1,0,1.5},{F,\[Omega]},\[Kappa]]
}
,{Row[{Text["\!\(\*SubscriptBox[\(p\), \(\[Perpendicular]\)]\)="],Button[Dynamic[po/.{a_/;(a>=0)->"+",a_/;(a<0)->"-"}],po=-po],InputField[Dynamic[Abs[po],(po=If[po!=0,Sign[po]#,#])&],FieldSize->3],Text[" \!\(\*SubscriptBox[\(p\), \(\[DoubleVerticalBar]\)]\)="],Button[Dynamic[pp/.{a_/;(a>=0)->"+",a_/;(a<0)->"-"}],pp=-pp],InputField[Dynamic[Abs[pp],(pp=If[pp!=0,Sign[pp]#,#])&],FieldSize->3]}]
}}]


SetAttributes[contourProgressController,HoldAll];
contourProgressController[sMan_]:=Row[{Text["Contour progress: "],Manipulator[Dynamic[sMan],Appearance->{"Labeled"}]}]


SetAttributes[tsController,HoldAll];
tsController[\[CapitalDelta]tss_,baretss_,tss_,{F_,\[Omega]_,\[Kappa]_}]:=Row[{Text["\!\(\*SubscriptBox[\(t\), \(s\)]\)="],
InputField[
Dynamic[tss,Function[input,(\[CapitalDelta]tss=Evaluate[input/.{"t\[Kappa]"->baretss-I/\[Kappa]^2,"ts"->baretss,"t0"->Re[baretss],"\[Tau]"->Im[baretss],"T"->2\[Pi]/\[Omega]}]-baretss),HoldRest]],
FieldSize->12]
,Button["\!\(\*SubscriptBox[\(t\), \(s\)]\)",\[CapitalDelta]tss=0],Button["\!\(\*SubscriptBox[\(t\), \(0\)]\)",\[CapitalDelta]tss=-I Im[baretss]]
}]


SetAttributes[rInitController,HoldAll];
rInitController[xinit_,zinit_,rInitRange_]:=Grid[{
{Text["\!\(\*SubscriptBox[\(x\), \(init\)]\) "],Button[Dynamic[xinit/.{a_/;(a>=0)->"+",a_/;(a<0)->"-"}],xinit=-xinit],
Manipulator[Dynamic[Abs[xinit],(xinit=If[xinit!=0,Sign[xinit]#,#])&],{0,rInitRange},Appearance->{"Labeled"}]},
{Text["\!\(\*SubscriptBox[\(z\), \(init\)]\) "],Button[Dynamic[zinit/.{a_/;(a>=0)->"+",a_/;(a<0)->"-"}],zinit=-zinit],
Manipulator[Dynamic[Abs[zinit],(zinit=If[zinit!=0,Sign[zinit]#,#])&],{0,rInitRange},Appearance->{"Labeled"}]}
}]


dashboardPlotter[{F_,\[Omega]_},\[Kappa]_,initialpath_: {"t\[Kappa]","t0","T"},{poinit_:0.15,ppinit_:0.15}]:=DynamicModule[
{po=poinit,pp=ppinit,py=0,sMan=0.1,t,rules
(*,r2,poTrajectory,pyTrajectory,ppTrajectory,re2Trajecotry*)
,trajectory
,expr,labels
,path,barepath=initialpath,\[CapitalDelta]path=Table[0,{Length[initialpath]}]
,tss,baretss,\[CapitalDelta]tss=0
,xinit=0,zinit=0,rInitRange=0.15
,r2range={{All,All},{All,All}},r2FullRange=All,r2plot
,tRangeSymbolic={{All,All},{All,All}},tRangeNumeric
,updateDefinitions(*, timecontours,timepath*)
},

(*ret,
Evaluate[If[#===All,"t0"-10/.rules,#]&[range\[LeftDoubleBracket]1,1\[RightDoubleBracket]]],
Evaluate[If[#===All,Re[Last[path]]+10/.rules,#]&[range\[LeftDoubleBracket]1,2\[RightDoubleBracket]]]
},{imt,
Evaluate[If[#===All,-10,#]&[range\[LeftDoubleBracket]2,1\[RightDoubleBracket]]],
Evaluate[If[#===All,Max[Im[tss]+10,15],#]&[range\[LeftDoubleBracket]2,2\[RightDoubleBracket]]]
}*)
updateDefinitions[]:=(
baretss=ts[{po,py,pp},{F,\[Omega],\[Kappa]}];
tss=baretss+\[CapitalDelta]tss;
rules={"t\[Kappa]"->tss-I/\[Kappa]^2,"ts"->tss,"t0"->Re[tss],"\[Tau]"->Im[tss],"T"-> 2\[Pi]/\[Omega]};
tRangeNumeric=(({
{
If[#[[1,1]]===All,"t0"-10,#[[1,1]]],
If[#[[1,2]]===All,Re[Last[path]]+10,#[[1,2]]]
},{
If[#[[2,1]]===All,-10,#[[2,1]]],
If[#[[2,2]]===All,Max[Im[tss]+10,15],#[[2,2]]]
}}&[tRangeSymbolic])/.rules);
path=Evaluate[barepath/.rules]+\[CapitalDelta]path;
t=Interpolation[Evaluate[{Range[0,1,1/(Length[path]-1)],path}\[Transpose]],InterpolationOrder->1];
trajectory:=Function[t,complexTrajectory[t,{po,py,pp}, {F,\[Omega],\[Kappa]},rInit->{xinit,0,zinit},forcets->tss]];
);
Dynamic[updateDefinitions[];""]

Framed[Grid[
{{(*Top row: controllers.*)
contourProgressController[sMan],
tsController[\[CapitalDelta]tss,baretss,tss,{F,\[Omega],\[Kappa]}],
rInitController[xinit,zinit,rInitRange]
},{(*Middle row*)
Dynamic[trajectoryPlotter[trajectory[t[#]][[1]]&,"\!\(\*SubscriptBox[\(x\), \(cl\)]\)(t)",sMan,"PlotRange"->All]],
Dynamic[trajectoryPlotter[trajectory[t[#]][[3]]&,"\!\(\*SubscriptBox[\(z\), \(cl\)]\)(t)",sMan,"PlotRange"->All]],
Dynamic[timeIntegrandPlotter[Total[trajectory[t[#]]^2]&,t,ImageSize->{720,360}]]
},{(*Bottom row*)
(*Momentum plane / ionization probability*)
momentumPlaneControls[{po,py,pp},{F,\[Omega],\[Kappa]}]
,(*r^2 plane - trajectory*)
Column[{
Dynamic[
trajectoryPlotter[Total[trajectory[t[#]]^2]&,"\!\(\*SubscriptBox[\(r\), \(cl\)]\)(t\!\(\*SuperscriptBox[\()\), \(2\)]\)",sMan,"PlotRange"->r2range]
]
,(*r^2 plane range controls*)
rangeReset[r2range,{"Re(\!\(\*SuperscriptBox[\(r\), \(2\)]\))","Im(\!\(\*SuperscriptBox[\(r\), \(2\)]\))"}]
},Center]
,(*time plane - path chooser.*)
Column[{
LocatorPane[
Dynamic[
{Re[path],Im[path]}\[Transpose]~Join~{{Re[tss],Im[tss]}},
Function[points,(\[CapitalDelta]path=(Complex@@@points[[1;;-2]])-Evaluate[barepath/.rules]);(\[CapitalDelta]tss=Complex@@points[[-1]]-baretss);updateDefinitions[],HoldRest]
],
Dynamic[
Show[
timeContours[Total[trajectory[#]^2]&,rules,tss,path,tRangeNumeric,ImageSize->{720,360}],
timePathPlotter[rules,t,sMan]
]
]
]
,Dynamic[trajectory]
,(*Time plane range controls*)
rangeReset[tRangeSymbolic,{"Re(t)","Im(t)"}]
},Center]
}}
]]
,SaveDefinitions->True]



