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



BeginPackage["ARMSupport`",{"EPToolbox`"}]


stdpars={0.05,0.055,1.007};


r0={0,0,0};


ts[pp_,\[Kappa]_,\[Omega]_,F_,po_,py_]:=1/\[Omega] ArcSin[\[Omega]/F pp+I \[Omega]/F Sqrt[\[Kappa]^2+po^2+py^2]]
ts[{po_,py_,pp_},{F_,\[Omega]_,\[Kappa]_}]:=ts[pp,\[Kappa],\[Omega],F,po,py]

t0[{po_,py_,pp_},{F_,\[Omega]_,\[Kappa]_}]:=Re[ts[pp,\[Kappa],\[Omega],F,po,py]]
t0[pp_,\[Kappa]_,\[Omega]_,F_,po_,py_]:=Re[ts[pp,\[Kappa],\[Omega],F,po,py]]

\[Tau][{po_,py_,pp_},{F_,\[Omega]_,\[Kappa]_}]:=Im[ts[pp,\[Kappa],\[Omega],F,po,py]]
\[Tau][pp_,\[Kappa]_,\[Omega]_,F_,po_,py_]:=Im[ts[pp,\[Kappa],\[Omega],F,po,py]]

t\[Kappa][pp_,\[Kappa]_,\[Omega]_,F_,po_,py_]:=ts[pp,\[Kappa],\[Omega],F,po,py]-I/\[Kappa]^2
t\[Kappa][{po_,py_,pp_},{F_,\[Omega]_,\[Kappa]_}]:=t\[Kappa][pp,\[Kappa],\[Omega],F,po,py]


ts::usage="ts[{po, py, pp}, {F, \[Omega], \[Kappa]}] Returns the saddle point \!\(\*SubscriptBox[\(t\), \(s\)]\) directly.

ts[pp, \[Kappa], \[Omega], F, po, py] Returns the saddle point \!\(\*SubscriptBox[\(t\), \(s\)]\) directly.";
t0::usage="t0[{po, py, pp}, {F, \[Omega], \[Kappa]}] Returns \!\(\*SubscriptBox[\(t\), \(0\)]\)=Re[\!\(\*SubscriptBox[\(t\), \(s\)]\)] directly.

t0[pp, \[Kappa], \[Omega], F, po, py] Returns \!\(\*SubscriptBox[\(t\), \(0\)]\)=Re[\!\(\*SubscriptBox[\(t\), \(s\)]\)] directly.";
\[Tau]::usage="\[Tau][{po, py, pp}, {F, \[Omega], \[Kappa]}] Returns \!\(\*SubscriptBox[\(\[Tau]\), \(T\)]\)=Im[\!\(\*SubscriptBox[\(t\), \(s\)]\)] directly.

\[Tau][pp, \[Kappa], \[Omega], F, po, py] Returns \!\(\*SubscriptBox[\(\[Tau]\), \(T\)]\)=Im[\!\(\*SubscriptBox[\(t\), \(s\)]\)] directly.";
t\[Kappa]::usage="t\[Kappa][{po, py, pp}, {F, \[Omega], \[Kappa]}] Returns the starting point \!\(\*SubscriptBox[\(t\), \(\[Kappa]\)]\) directly.

t\[Kappa][pp, \[Kappa], \[Omega], F, po, py] Returns the starting point \!\(\*SubscriptBox[\(t\), \(\[Kappa]\)]\) directly.";


getClassicalTransition[n_,{F_,\[Omega]_,\[Kappa]_}]:=getClassicalTransition[n,F,\[Omega],\[Kappa]]
getClassicalTransition[range_List,{F_,\[Omega]_,\[Kappa]_}]:=(getClassicalTransition[#,{F,\[Omega],\[Kappa]}]&/@range)
getClassicalTransition[n_,F_,\[Omega]_,\[Kappa]_]:=Module[{getTimes,t00,zinit},
getTimes[pz_]:=({t0->Re[#],\[Tau]->Im[#]}&[1/\[Omega] ArcSin[\[Omega]/F (pz+I \[Kappa])]]);
t00[pz_?NumericQ]:=(t0/.getTimes[pz]);
zinit[pz_?NumericQ]:=Re[F/\[Omega]^2 (Cos[\[Omega] t0]-Cos[\[Omega] (t0+I \[Tau]-I/\[Kappa]^2)])/.getTimes[pz]];
FindRoot[
{pz(tr-t00[pz])+F/\[Omega]^2 (Cos[\[Omega] tr]-Cos[\[Omega] t00[pz]])+zinit[pz]==0,
pz-F/\[Omega] Sin[\[Omega] tr]==0}
,{{pz,0},{tr,(n+1) \[Pi]/\[Omega]}}
]
]


getClassicalTransition::usage="getClassicalTransition[n, {F, \[Omega], \[Kappa]}] Returns pz and tr in atomic units as a list of replacement rules.
getClassicalTransition[range, {F, \[Omega], \[Kappa]}]
getClassicalTransition[n, F, \[Omega], \[Kappa]]";


getLinearizedTransition[n_,{F_,\[Omega]_,\[Kappa]_}]:=getClassicalTransition[n,F,\[Omega],\[Kappa]]
getLinearizedTransition[range_List,{F_,\[Omega]_,\[Kappa]_}]:=(getClassicalTransition[#,{F,\[Omega],\[Kappa]}]&/@range)
getLinearizedTransition[n_,F_,\[Omega]_,\[Kappa]_]:={pz->F/\[Omega] getReducedLinearizedTransition[n,(\[Omega] \[Kappa])/F],tr->1/\[Omega] ((n+1)\[Pi]+ArcSin[getReducedLinearizedTransition[n,(\[Omega] \[Kappa])/F]])}


getReducedLinearizedTransition[range_List,\[Gamma]_]:=(getReducedLinearizedTransition[#,\[Gamma]]&/@range)
getReducedLinearizedTransition[n_,\[Gamma]_]:=((-1)^n+Sqrt[1+\[Gamma]^2])/(\[Pi](n+1))


getReducedLinearizedTransition::usage="getReducedLinearizedTransition[n, {F, \[Omega], \[Kappa]}] Returns \[Omega]pz/F directly.
getReducedLinearizedTransition[range, {F, \[Omega], \[Kappa]}]
getReducedLinearizedTransition[n, F, \[Omega], \[Kappa]]";


getFullLinearizedTransition[n_,{F_,\[Omega]_,\[Kappa]_}]:=getFullLinearizedTransition[n,F,\[Omega],\[Kappa]]
getFullLinearizedTransition[range_List,{F_,\[Omega]_,\[Kappa]_}]:=(getFullLinearizedTransition[#,{F,\[Omega],\[Kappa]}]&/@range)
getFullLinearizedTransition[n_,F_,\[Omega]_,\[Kappa]_]:={pz->F/\[Omega] getFullReducedLinearizedTransition[n,(\[Omega] \[Kappa])/F],tr->1/\[Omega] ((n+1)\[Pi]+ArcSin[getReducedLinearizedTransition[n,(\[Omega] \[Kappa])/F]])}
getFullReducedLinearizedTransition[range_List,F_,\[Omega]_,\[Kappa]_]:=(getFullReducedLinearizedTransition[#,F,\[Omega],\[Kappa]]&/@range)
getFullReducedLinearizedTransition[n_,F_,\[Omega]_,\[Kappa]_]:=((-1)^n+Sqrt[1+((\[Omega] \[Kappa])/F)^2]Cosh[\[Omega]/\[Kappa]^2]-(\[Omega] \[Kappa])/F Sinh[\[Omega]/\[Kappa]^2])/((n+1)\[Pi])


getFullLinearizedTransition::usage="getFullLinearizedTransition[n, {F, \[Omega], \[Kappa]}] Returns pz and tr in atomic units as a list of replacement rules, for the linearized case without neglecting \[Omega]/\[Kappa]^2.
getFullLinearizedTransition[range, {F, \[Omega], \[Kappa]}]
getFullLinearizedTransition[n, F, \[Omega], \[Kappa]]";
getFullReducedLinearizedTransition::usage="getFullReducedLinearizedTransition[n, {F, \[Omega], \[Kappa]}] Returns \[Omega]pz/F directly.
getFullReducedLinearizedTransition[range, {F, \[Omega], \[Kappa]}]
getFullReducedLinearizedTransition[n, F, \[Omega], \[Kappa]]";


getComplexTransition[n_,{F_,\[Omega]_,\[Kappa]_}]:=getComplexTransition[n,F,\[Omega],\[Kappa]]
getComplexTransition[range_List,{F_,\[Omega]_,\[Kappa]_}]:=(getComplexTransition[#,{F,\[Omega],\[Kappa]}]&/@range)
getComplexTransition[n_,F_,\[Omega]_,\[Kappa]_]:=Module[{t\[Kappa]},
t\[Kappa][pz_]:=ts[pz,\[Kappa],\[Omega],F,0,0]-I/\[Kappa]^2;
FindRoot[
(\[Omega] pz)/F ((n+1) \[Pi]+ArcSin[(\[Omega] pz)/F]-\[Omega] t\[Kappa][pz])+(-1)^(n+1) Sqrt[1-((\[Omega] pz)/F)^2]-Cos[\[Omega] t\[Kappa][pz]]==0
,{pz,0.0}]
]


getComplexTransition::usage="getComplexTransition[n, {F, \[Omega], \[Kappa]}] Returns pz and tr in atomic units as a list of replacement rules.
getComplexTransition[range, {F, \[Omega], \[Kappa]}]
getComplexTransition[n, F, \[Omega], \[Kappa]]";


Options[complexTrajectory]={zInit->0,rInit->{0,0,0},forcets->Automatic};
complexTrajectory[t_,pz_,{F_,\[Omega]_,\[Kappa]_},OptionsPattern[]]:=With[{tss=If[OptionValue[forcets]===Automatic,ts[{0,0,pz},{F,\[Omega],\[Kappa]}],OptionValue[forcets]]},
OptionValue[zInit]+pz(t-tss)+F/\[Omega]^2 (Cos[\[Omega] t]-Cos[\[Omega] tss])
]
complexTrajectory[t_,{px_,py_,pz_},{F_,\[Omega]_,\[Kappa]_},OptionsPattern[]]:=With[{tss=If[OptionValue[forcets]===Automatic,ts[{px,py,pz},{F,\[Omega],\[Kappa]}],OptionValue[forcets]]},
OptionValue[rInit]+{px,py,pz}(t-tss)+{0,0,1} F/\[Omega]^2 (Cos[\[Omega] t]-Cos[\[Omega] tss])
]
complexTrajectory::usage="complexTrajectory[t,{px,py,pz},{F,\[Omega],\[Kappa]}] Returns the vector-valued complex trajectory \!\(\*SubscriptBox[\(r\), \(cl\)]\)(t)=\!\(\*SubsuperscriptBox[\(\[Integral]\), SubscriptBox[\(t\), \(s\)], \(t\)]\)(p+A(\[Tau]))\[DifferentialD]\[Tau].

complexTrajectory[t,pz,{F,\[Omega],\[Kappa]}] Returns the z component of the complex trajectory \!\(\*SubscriptBox[\(z\), \(cl\)]\)(t)=\!\(\*SubsuperscriptBox[\(\[Integral]\), SubscriptBox[\(t\), \(s\)], \(t\)]\)(\!\(\*SubscriptBox[\(p\), \(z\)]\)+A(\[Tau]))\[DifferentialD]\[Tau].";


rInit::usage="rInit is an option for complexTrajectory and classicalTrajectory which specifies the initial position for the trajectory at time \!\(\*SubscriptBox[\(t\), \(s\)]\).";
zInit::usage="zInit is an option for complexTrajectory and classicalTrajectory which specifies the initial z position for the trajectory at time \!\(\*SubscriptBox[\(t\), \(s\)]\).";
forcets::usage="forcets is an option for complexTrajectory and classicalTrajectory which specifies a start time \!\(\*SubscriptBox[\(t\), \(s\)]\) to use for the trajectory, or uses the Automatic one.";
Protect[rInit,zInit,forcets];


classicalTrajectory[t_,pz_,{F_,\[Omega]_,\[Kappa]_},OptionsPattern[zInit->0]]:=Re[complexTrajectory[t,pz,{F,\[Omega],\[Kappa]},zInit->OptionValue[zInit]]]
classicalTrajectory[t_?NumericQ,{px_,py_,pz_},{F_,\[Omega]_,\[Kappa]_},OptionsPattern[rInit->0]]:=Re[complexTrajectory[t,{px,py,pz},{F,\[Omega],\[Kappa]},rInit->OptionValue[rInit]]]
classicalTrajectory::usage="classicalTrajectory[t, {px, py, pz}, {F, \[Omega], \[Kappa]}] Returns the real part of the vector-valued complex trajectory, Re(\!\(\*SubscriptBox[\(r\), \(cl\)]\)(t))=Re(\!\(\*SubsuperscriptBox[\(\[Integral]\), SubscriptBox[\(t\), \(s\)], \(t\)]\)(p+A(\[Tau]))\[DifferentialD]\[Tau]).

classicalTrajectory[t, pz, {F, \[Omega], \[Kappa]}] Returns the real part of the z component  of the complex trajectory, Re(\!\(\*SubscriptBox[\(z\), \(cl\)]\)(t))=Re(\!\(\*SubsuperscriptBox[\(\[Integral]\), SubscriptBox[\(t\), \(s\)], \(t\)]\)(\!\(\*SubscriptBox[\(p\), \(z\)]\)+A(\[Tau]))\[DifferentialD]\[Tau]).";


Options[classicalClosestApproach]={"rules"->Automatic,"Range"->{0,2"T"}};
classicalClosestApproach[{px_,py_,pz_},{F_,\[Omega]_,\[Kappa]_},OptionsPattern[]]:=Module[
{tstart,zinit},
tstart=If[NumberQ[OptionValue["rules"]],
"t0"/.OptionValue["rules"],
Re[1/\[Omega] ArcSin[\[Omega]/F (pz+I Sqrt[\[Kappa]^2+px^2+py^2])]]
];
zinit=F/\[Omega]^2 Cos[\[Omega] tstart]-F/\[Omega]^2 Re[Cos[ArcSin[\[Omega]/F (pz+I Sqrt[\[Kappa]^2+px^2+py^2])]]];
If[Length[#]>0,t/.#,{}]&@Quiet[
NSolve[{
{px,py,pz-F/\[Omega] Sin[\[Omega] t]}.classicalTrajectory[t,{px,py,pz},{F,\[Omega],\[Kappa]}]==0,
Evaluate[OptionValue["Range"][[1]]<t<OptionValue["Range"][[2]]/.{"T"->(2\[Pi])/\[Omega]}]
},t]
]
]


classicalClosestApproach::usage="classicalClosestApproach[{px, py, pz}, {F, \[Omega], \[Kappa]}] Returns \!\(\*SubscriptBox[\(t\), \(CA\)]\), such that Re[\!\(\*SubscriptBox[\(r\), \(cl\)]\)(\!\(\*SubscriptBox[\(t\), \(CA\)]\))]\[CenterDot]v(\!\(\*SubscriptBox[\(t\), \(CA\)]\))=0, for the given momentum and parameters. Accepts \"rules\" as an option, as well as \"Range\" in the format {t1, t2}, where both can contain the laser period \"T\".";


rDotV[t_,{px_,py_,pz_},{F_,\[Omega]_,\[Kappa]_}]:=Module[{tss,zinit=F/\[Omega]^2 (1-Sqrt[1+((\[Kappa] \[Omega])/F)^2])},
tss=If[NumberQ[OptionValue["rules"]],
"t0"/.OptionValue["rules"],
Re[1/\[Omega] ArcSin[\[Omega]/F (pz+I Sqrt[\[Kappa]^2+px^2+py^2])]]
];
(px^2+py^2)(t-tss)+(pz(t-tss)+F/\[Omega]^2 (Cos[\[Omega] t]-Cos[\[Omega] tss])+zinit)(pz-F/\[Omega] Sin[\[Omega] t])
]


rDotV::usage="rDotV[t, px, pz, {F, \[Omega], \[Kappa]}] Returns the classical r(t)\[CenterDot]v(t) for the given momentum and parameters.";


rDotV[t_,px_,pz_,{F_,\[Omega]_,\[Kappa]_}]:=rDotV[t,px,pz,{F,\[Omega],\[Kappa]}]=rDotV[t,{px,0,pz},{F,\[Omega],\[Kappa]}]


d2r2[t_,{px_,py_,pz_},{F_,\[Omega]_,\[Kappa]_}]:=d2r2[t,{px,py,pz},{F,\[Omega],\[Kappa]}]=2(Norm[{px,py,pz}-{0,0,1} F/\[Omega] Sin[\[Omega] t]]^2-classicalTrajectory[t,pz,{F,\[Omega],\[Kappa]}]F Cos[\[Omega] t])


d2r2::usage="d2r2[t, {px, py, pz}, {F, \[Omega], \[Kappa]}] Returns the classical second time derivative \!\(\*FractionBox[SuperscriptBox[\(d\), \(2\)], SuperscriptBox[\(dt\), \(2\)]]\)\!\(\*SubsuperscriptBox[\(r\), \(cl\), \(2\)]\) at the given momentum and parameers.";


Options[allQuantumClosestApproachTimes]=Join[Options[FindComplexRoots],{"rules"->Automatic,"Range"->Automatic}];
allQuantumClosestApproachTimes[{po_,py_,pp_},{F_,\[Omega]_,\[Kappa]_},{xinit_,yinit_,zinit_},options:OptionsPattern[]]:=Module[
{tss,range,rules},
tss=If[OptionValue["rules"]===Automatic,ts[pp,\[Kappa],\[Omega],F,po,py],"ts"/.OptionValue["rules"]];
rules=If[OptionValue["rules"]===Automatic,
{"t\[Kappa]"->tss-I/\[Kappa]^2,"ts"->tss,"t0"->Re[tss],"\[Tau]"->Im[tss],"T"->2\[Pi]/\[Omega]},
OptionValue[rules]
];
range=Which[
MatchQ[OptionValue["Range"]/.rules,{a_?NumericQ,b_?NumericQ}/;Im[b-a]<=0],(OptionValue[Range]/.rules)+{-2I Im[tss],2I Im[tss]},
MatchQ[OptionValue["Range"]/.rules,{_?NumericQ,_?NumericQ}],(OptionValue[Range]/.rules),
True,{-2I Im[tss],(2\[Pi])/\[Omega]+2I Im[tss]}
];
Sort@FindComplexRoots[
2({xinit,yinit,zinit}+{po,py,pp}(tCA-tss)+{0,0,F/\[Omega]^2 (Cos[\[Omega] tCA]-Cos[\[Omega] tss])}).{po,py,pp-F/\[Omega] Sin[\[Omega] tCA]}==0
,{tCA,range[[1]],range[[2]]}
,Sequence@@FilterRules[{options},Options[FindComplexRoots]]
,Seeds->200
,Tolerance->10^(4-$MachinePrecision)
]
]
allQuantumClosestApproachTimes::usage="allQuantumClosestApproachTimes[{px, py, pz}, {F, \[Omega], \[Kappa]}, {xinit, yinit, zinit}] returns the quantum tCAs as a list of complex values. It accepts as options an explicit \"ts\" and a \"Range\", set to {-2\[ImaginaryI]\[Tau], T+2\[ImaginaryI]\[Tau]} by default, as well as all the options of EPToolbox`FindComplexRoots.";


Options[makeTCAsFromCircuit]=Join[{"rules"->Automatic,OptionValue["Range"]->Automatic,PlotRange->Automatic},Options[allQuantumClosestApproachTimes]];
makeTCAsFromCircuit[circuit_,{F_,\[Omega]_,\[Kappa]_},{xinit_,yinit_,zinit_},options:OptionsPattern[]]:=Module[
{range,rules,tss,n,pvec},
Flatten[ParallelTable[
{n,pvec}=element;
Needs["EPToolbox`","/home/episanty/Work/CQD/Project/Code/EPToolbox/EPToolbox/EPToolbox.m"];
tss=If[OptionValue["rules"]===Automatic,ts[pvec[[1]],\[Kappa],\[Omega],F,pvec[[1]]],"ts"/.OptionValue["rules"]];
rules=If[OptionValue["rules"]===Automatic,
{"t\[Kappa]"->tss-I/\[Kappa]^2,"ts"->tss,"t0"->Re[tss],"\[Tau]"->Im[tss],"T"->2\[Pi]/\[Omega]},
OptionValue[rules]
];
range=Automatic;
range=Which[
MatchQ[OptionValue["Range"]/.rules,{_?NumericQ,_?NumericQ}],OptionValue["Range"]/.rules,
MatchQ[OptionValue[PlotRange]/.rules,{{_?NumericQ,_?NumericQ},{_?NumericQ,_?NumericQ}}],Complex@@@(OptionValue[PlotRange]\[Transpose]/.rules),
True,{-2I Im[tss],(2\[Pi])/\[Omega]+2I Im[tss]}
];(*ugly logic inside the Table because range depends on tss which depends on p*)
{n,pvec,tCA}/.allQuantumClosestApproachTimes[{pvec[[1]],0,pvec[[2]]},{F,\[Omega],\[Kappa]},{xinit,yinit,zinit}
,Sequence@@FilterRules[{options},Options[allQuantumClosestApproachTimes]],"Range"->range
]
,{element,circuit}],1]
]
makeTCAsFromCircuit::usage="makeTCAsFromCircuit[{{n1, {px1, py1, pz1}}, ..., {nN, {pxnN, pynN, pznN}}}, {F, \[Omega], \[Kappa]}, {xinit, yinit, zinit}] Calculates the tCAs for the given circuit and parameters. The ni can be any tags which are returned with the output, which is of the form {{n1, {px1, py1, pz1}, tCA11}, {n1, {px1, py1, pz1}, tCA12}, ..., {nN, {pxnN, pynN, pznN}, tCAnNk}}, with all the appropriate tCA in separate entries. Same \"rules\" and \"Range\" options as allQuantumClosestApproachTimes.";


Options[makeTCAsFromRange]=Join[{"rules"->Automatic,OptionValue["Range"]},Options[allQuantumClosestApproachTimes]];
makeTCAsFromRange[{pomin_,pomax_,\[Delta]po_},{ppmin_,ppmax_,\[Delta]pp_},fixedMomenta_,{F_,\[Omega]_,\[Kappa]_},{xinit_,yinit_,zinit_},options:OptionsPattern[]]:=Module[
{range,rules,tss},
tss=If[OptionValue["rules"]===Automatic,ts[pp,\[Kappa],\[Omega],F,po,py],"ts"/.OptionValue["rules"]];
rules=If[OptionValue["rules"]===Automatic,
{"t\[Kappa]"->tss-I/\[Kappa]^2,"ts"->tss,"t0"->Re[tss],"\[Tau]"->Im[tss],"T"->2\[Pi]/\[Omega]},
OptionValue[rules]
];
Flatten[
Table[
range=Which[
MatchQ[OptionValue["Range"]/.rules/.fixedMomenta,{_?NumericQ,_?NumericQ}],OptionValue["Range"]/.rules,
MatchQ[OptionValue[PlotRange]/.rules/.fixedMomenta,{{_?NumericQ,_?NumericQ},{_?NumericQ,_?NumericQ}}],Complex@@@(OptionValue[PlotRange]\[Transpose]/.rules),
True,{-2I Im[tss],(2\[Pi])/\[Omega]+2I Im[tss]}
]/.fixedMomenta;(*ugly logic inside the Table because range depends on tss which depends on p*)
{{po,py,pp}/.fixedMomenta,tCA}/.allQuantumClosestApproachTimes[{po,py,pp}/.fixedMomenta,{F,\[Omega],\[Kappa]},{xinit,yinit,zinit}
,"Range"->range,Sequence@@FilterRules[{options},Options[allQuantumClosestApproachTimes]]
]
,{po,pomin,pomax,\[Delta]po},{pp,ppmin,ppmax,\[Delta]pp}]
,{1,2,3}]
]
makeTCAsFromRange::usage="makeTCAsFromRange[{pomin, pomax, \[Delta]po}, {ppmin, ppmax, \[Delta]pp}, fixedMomenta, {F, \[Omega], \[Kappa]}, {xinit, yinit, zinit}, \"Range\"\[Rule]{t1, t2}] Returns a list with elements of the form {{po, py, pp}, tCA} for a rectangular grid in momentum with the given spans and separations. fixedMomenta should be a list of replacement rules such as {py\[Rule]0}.";


Options[closestApproachTimesPath]=Join[{v2Tolerance->Automatic},Options[allQuantumClosestApproachTimes],Options[ListPlot]];
closestApproachTimesPath[{po_,py_,pp_},{F_,\[Omega]_,\[Kappa]_},{xinit_,yinit_,zinit_},options:OptionsPattern[]]:=Module[
{tss,r,v,range,rules,v2tol},
tss=If[OptionValue["rules"]===Automatic,ts[pp,\[Kappa],\[Omega],F,po,py],"ts"/.OptionValue["rules"]];
rules=If[OptionValue["rules"]===Automatic,
{"t\[Kappa]"->tss-I/\[Kappa]^2,"ts"->tss,"t0"->Re[tss],"\[Tau]"->Im[tss],"T"->2\[Pi]/\[Omega]},
OptionValue[rules]
];
v2tol=Which[OptionValue[v2Tolerance]===Automatic,10^-8,True,OptionValue[v2Tolerance]];
r[tt_]:=({xinit,yinit,zinit}+{po,py,pp}(tt-tss)+{0,0,F/\[Omega]^2 (Cos[\[Omega] tt]-Cos[\[Omega] tss])});
v[tt_]:=({po,py,pp}+{0,0,-(F/\[Omega])Sin[\[Omega] tt]});
range=Which[
MatchQ[OptionValue["Range"]/.rules,{_?NumericQ,_?NumericQ}],OptionValue["Range"]/.rules,
MatchQ[OptionValue[PlotRange]/.rules,{{_?NumericQ,_?NumericQ},{_?NumericQ,_?NumericQ}}],Complex@@@(OptionValue[PlotRange]\[Transpose]/.rules),
True,{-2I Im[tss],(2\[Pi])/\[Omega]+2I Im[tss]}
];
Select[
Sort[
allQuantumClosestApproachTimes[{po,py,pp},{F,\[Omega],\[Kappa]},{xinit,yinit,zinit}
,"Range"->range
,Sequence@@FilterRules[{options},Options[allQuantumClosestApproachTimes]]
,Tolerance->10^(4-$MachinePrecision)],
((Re[tCA]/.#1)<(Re[tCA]/.#2))&
],
(Or[
And[1/4 (2\[Pi])/\[Omega]<Re[tCA]<3/4 (2\[Pi])/\[Omega],Im[tCA]>0],
And[-(1/4) (2\[Pi])/\[Omega]<Re[tCA]<1/4 (2\[Pi])/\[Omega],Im[tCA]>=0,Im[Sin[\[Omega] tCA]]<\[Omega] \[Kappa]/F],
And[(-0.3Im[tss]<=Im[tCA]<Im[tss]-1/\[Kappa]^2),(Re[tCA]-0.1 (2\[Pi])/\[Omega]>Re[tss]),(Re[v[tCA].v[tCA]]>=-v2tol)]
]/.#&)
]
]
closestApproachTimesPath::usage="closestApproachTimesPath[{px, py, pz}, {F, \[Omega], \[Kappa]}, {xinit, yinit, zinit}] Returns a selected and ordered list of complex tCAs as replacement rules, in atomic units. Accepts the same \"rules\" and \"Range\" options as allQuantumClosestApproachTimes.";
v2Tolerance::usage="v2Tolerance is an option for closestApproachTimesPath which determines the tolerance v2tol to be used when selecting tCAs for the path. Time tCA is included in the path if Re[v[tCA]^2]\[GreaterEqual]-v2tol.";Protect[v2Tolerance];
(*closestApproachTimesPath[{0.05,0,1.2},stdpars,{0,0,0},"Range"\[Rule]{-5\[ImaginaryI],5.6"T"+30\[ImaginaryI]}]*)


(*FullSimplify[Re[
\[ImaginaryI] Integrate[\[Kappa]^2/2+1/2(po^2+py^2)+1/2(pp-F/\[Omega]Sin[\[Omega] t])^2,{t,0,1/\[Omega]ArcSin[\[Omega]/F(pp+\[ImaginaryI] Sqrt[\[Kappa]^2+po^2+py^2])]}]/.{Sin[2u_]\[Rule]2Sin[u]Cos[u]}
]]*)
volkovExponent[{po_,py_,pp_},{F_,\[Omega]_},\[Kappa]_]:=-(1/8) Im[1/\[Omega]^3 (2 F \[Omega] (-4 pp+3 pp Sqrt[1+((-I pp+Sqrt[po^2+py^2+\[Kappa]^2])^2 \[Omega]^2)/F^2]-I Sqrt[po^2+py^2+\[Kappa]^2] Sqrt[1+((-I pp+Sqrt[po^2+py^2+\[Kappa]^2])^2 \[Omega]^2)/F^2])+2 (F^2+2 (po^2+pp^2+py^2+\[Kappa]^2) \[Omega]^2) ArcSin[((pp+I Sqrt[po^2+py^2+\[Kappa]^2]) \[Omega])/F])]
(*Note that this version is out of line with the 'main file'. Renamed from simply 'exponent' on this file on 10.03.*)
volkovExponent[{po_,py_,pp_},{F_,\[Omega]_,\[Kappa]_}]:=volkovExponent[{po,py,pp},{F,\[Omega]},\[Kappa]]

volkovExponent::usage="volkovExponent[{po, py, pp}, {F, \[Omega], \[Kappa]}] calculates Re(\[ImaginaryI]\!\(\*SubsuperscriptBox[\(\[Integral]\), \(0\), SubscriptBox[\(t\), \(s\)]]\)(\!\(\*SubscriptBox[\(I\), \(p\)]\)+\!\(\*FractionBox[\(1\), \(2\)]\)(p+A(\[Tau])\!\(\*SuperscriptBox[\()\), \(2\)]\))\[DifferentialD]\[Tau]).";


SetSharedFunction[Sow];
Quiet[ReportingFunction=ReportingFunction;Softening=Softening;]
Protect[ReportingFunction];Protect[Softening];
coulombCorrection::intErrors="Integration errors obtained at input {{po, py, pp}, {F, \[Omega], \[Kappa]}, path}=`1`";

Options[coulombCorrection]=Join[{Softening->None,ReportingFunction->Sow},Options[closestApproachTimesPath]];
coulombCorrection[{po_,py_,pp_},{F_,\[Omega]_,\[Kappa]_},path_:{"t\[Kappa]","t0"},options:OptionsPattern[]]:=Block[
{tss,iterator,rules,range,tCApath,int,\[Sigma]},
\[Sigma]=Which[NumberQ[OptionValue[Softening]],OptionValue[Softening],OptionValue[Softening]===Automatic,1/\[Kappa],True,0];(*Coulomb softening*)
tss=ts[pp,\[Kappa],\[Omega],F,po,py];
rules={"t\[Kappa]"->tss-I/\[Kappa]^2,"ts"->tss,"t0"->Re[tss],"\[Tau]"->Im[tss],"T"->2\[Pi]/\[Omega]};
range=({Re[First[path]]-2I "\[Tau]",Re[Last[path]]+2I "\[Tau]"}/.rules);
If[
!FreeQ[path,"tCApath"],
tCApath=Chop[tCA/.closestApproachTimesPath[{po,py,pp},{F,\[Omega],\[Kappa]},{0,0,0},Sequence@@FilterRules[{options},Options[closestApproachTimesPath]],"Range"->range]];
If[Length[tCApath]>0,
AppendTo[rules,"tCApath"->Apply[Sequence,tCApath]],
AppendTo[rules,"tCApath"->(##&[])]
]
];(*Print[rules];*)
iterator={t,Sequence@@Evaluate[path/.rules]};(*Print[iterator];*)
Check[
int=NIntegrate[-((po^2+py^2)(t-tss)^2+(pp(t-tss)+F/\[Omega]^2 (Cos[\[Omega] t]-Cos[\[Omega] tss]))^2+\[Sigma]^2)^(-1/2),Evaluate@iterator],
OptionValue[ReportingFunction][Chop[{{po,py,pp},{F,\[Omega],\[Kappa]},path}]];Message[coulombCorrection::intErrors,Chop[{{po,py,pp},{F,\[Omega],\[Kappa]},path}]];int
]
]
coulombCorrection::usage="coulombCorrection[{px, py, pz}, {F, \[Omega], \[Kappa]}, path] Calculates the Coulomb correction integral over the specified path. The path is a list which may contain \"t\[Kappa]\", \"ts\", \"t0\", \"\[Tau]\", \"tCApath\" and \"T\", which will be replaced by the appropriate points.";
Softening::usage="Softening is an option for coulombCorrection which specifies whether the Coulomb kernel should be softened by a length \[Sigma]. It is set by default to None (\[Sigma]=0), and it can be changed to Automatic (\[Sigma]=1/\[Kappa]) or a numeric value for \[Sigma].";
ReportingFunction::usage="ReportingFunction is an option for coulombCorrection to specify the reporting of error-producing inputs. It should speficy a function f, set by default to Sow, which will be called as f[{{po, py, pp}, {F, \[Omega], \[Kappa]}, path}] if the inputs produce any errors during the NIntegrate call. To print to a file use ReportToFile.";


ReportToFile[directory_,file_]:=Function[expr,Run["cd "<>directory<>" && echo "<>StringReplace[ToString[expr/.{s_String:>StringJoin["\"",s,"\""]},CharacterEncoding->"ASCII"],{" "->"\\ ","\\"->"\\\\","\""->"\\\""}]<>" >> "<>StringReplace[file,{" "->"\\ ","\\"->"\\\\","\""->"\\\""}]]]
ReportToFile::usage="ReportToFile[directory, file] returns a function which can be used as a value for ReportingFunction inside coulombCorrection.\n\nReportToFile[directory, file][expr] adds a line with expr (properly parsed to ASCII for spaces, backslashes and quote marks) to directory/file.";


EndPackage[]
