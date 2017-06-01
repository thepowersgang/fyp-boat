<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE eagle SYSTEM "eagle.dtd">
<eagle version="6.6.0">
<drawing>
<settings>
<setting alwaysvectorfont="no"/>
<setting verticaltext="up"/>
</settings>
<grid distance="0.1" unitdist="inch" unit="inch" style="lines" multiple="1" display="no" altdistance="0.01" altunitdist="inch" altunit="inch"/>
<layers>
<layer number="1" name="Top" color="4" fill="1" visible="no" active="no"/>
<layer number="16" name="Bottom" color="1" fill="1" visible="no" active="no"/>
<layer number="17" name="Pads" color="2" fill="1" visible="no" active="no"/>
<layer number="18" name="Vias" color="2" fill="1" visible="no" active="no"/>
<layer number="19" name="Unrouted" color="6" fill="1" visible="no" active="no"/>
<layer number="20" name="Dimension" color="15" fill="1" visible="no" active="no"/>
<layer number="21" name="tPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="22" name="bPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="23" name="tOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="24" name="bOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="25" name="tNames" color="7" fill="1" visible="no" active="no"/>
<layer number="26" name="bNames" color="7" fill="1" visible="no" active="no"/>
<layer number="27" name="tValues" color="7" fill="1" visible="no" active="no"/>
<layer number="28" name="bValues" color="7" fill="1" visible="no" active="no"/>
<layer number="29" name="tStop" color="7" fill="3" visible="no" active="no"/>
<layer number="30" name="bStop" color="7" fill="6" visible="no" active="no"/>
<layer number="31" name="tCream" color="7" fill="4" visible="no" active="no"/>
<layer number="32" name="bCream" color="7" fill="5" visible="no" active="no"/>
<layer number="33" name="tFinish" color="6" fill="3" visible="no" active="no"/>
<layer number="34" name="bFinish" color="6" fill="6" visible="no" active="no"/>
<layer number="35" name="tGlue" color="7" fill="4" visible="no" active="no"/>
<layer number="36" name="bGlue" color="7" fill="5" visible="no" active="no"/>
<layer number="37" name="tTest" color="7" fill="1" visible="no" active="no"/>
<layer number="38" name="bTest" color="7" fill="1" visible="no" active="no"/>
<layer number="39" name="tKeepout" color="4" fill="11" visible="no" active="no"/>
<layer number="40" name="bKeepout" color="1" fill="11" visible="no" active="no"/>
<layer number="41" name="tRestrict" color="4" fill="10" visible="no" active="no"/>
<layer number="42" name="bRestrict" color="1" fill="10" visible="no" active="no"/>
<layer number="43" name="vRestrict" color="2" fill="10" visible="no" active="no"/>
<layer number="44" name="Drills" color="7" fill="1" visible="no" active="no"/>
<layer number="45" name="Holes" color="7" fill="1" visible="no" active="no"/>
<layer number="46" name="Milling" color="3" fill="1" visible="no" active="no"/>
<layer number="47" name="Measures" color="7" fill="1" visible="no" active="no"/>
<layer number="48" name="Document" color="7" fill="1" visible="no" active="no"/>
<layer number="49" name="Reference" color="7" fill="1" visible="no" active="no"/>
<layer number="51" name="tDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="52" name="bDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="91" name="Nets" color="2" fill="1" visible="yes" active="yes"/>
<layer number="92" name="Busses" color="1" fill="1" visible="yes" active="yes"/>
<layer number="93" name="Pins" color="2" fill="1" visible="no" active="yes"/>
<layer number="94" name="Symbols" color="4" fill="1" visible="yes" active="yes"/>
<layer number="95" name="Names" color="7" fill="1" visible="yes" active="yes"/>
<layer number="96" name="Values" color="7" fill="1" visible="yes" active="yes"/>
<layer number="97" name="Info" color="7" fill="1" visible="yes" active="yes"/>
<layer number="98" name="Guide" color="6" fill="1" visible="yes" active="yes"/>
</layers>
<schematic xreflabel="%F%N/%S.%C%R" xrefpart="/%S.%C%R">
<libraries>
<library name="parts">
<packages>
<package name="ARDUCOPTER2.8">
<smd name="U$20-1" x="-13.97" y="8.89" dx="1.27" dy="0.635" layer="1"/>
<smd name="U$20-2" x="-13.97" y="7.62" dx="1.27" dy="0.635" layer="1"/>
<smd name="U$20-3" x="-13.97" y="6.35" dx="1.27" dy="0.635" layer="1"/>
<smd name="U$20-4" x="-13.97" y="5.08" dx="1.27" dy="0.635" layer="1"/>
<smd name="U$20-5" x="-13.97" y="3.81" dx="1.27" dy="0.635" layer="1"/>
<pad name="A0" x="-8.89" y="8.89" drill="0.8" shape="square"/>
<pad name="A1" x="-7.62" y="8.89" drill="0.8" shape="square"/>
<pad name="A2" x="-6.35" y="8.89" drill="0.8" shape="square"/>
<pad name="A3" x="-5.08" y="8.89" drill="0.8" shape="square"/>
<pad name="A4" x="-3.81" y="8.89" drill="0.8" shape="square"/>
<pad name="A5" x="-2.54" y="8.89" drill="0.8" shape="square"/>
<pad name="A6" x="-1.27" y="8.89" drill="0.8" shape="square"/>
<pad name="A7" x="0" y="8.89" drill="0.8" shape="square"/>
<pad name="A8" x="1.27" y="8.89" drill="0.8" shape="square"/>
<wire x1="-15.24" y1="10.16" x2="19.05" y2="10.16" width="0.127" layer="1"/>
<wire x1="19.05" y1="10.16" x2="19.05" y2="-8.89" width="0.127" layer="1"/>
<wire x1="19.05" y1="-8.89" x2="-15.24" y2="-8.89" width="0.127" layer="1"/>
<wire x1="-15.24" y1="-8.89" x2="-15.24" y2="10.16" width="0.127" layer="1"/>
<pad name="O1" x="-13.97" y="1.27" drill="0.8" shape="square"/>
<pad name="O2" x="-13.97" y="0" drill="0.8" shape="square"/>
<pad name="O3" x="-13.97" y="-1.27" drill="0.8" shape="square"/>
<pad name="O4" x="-13.97" y="-2.54" drill="0.8" shape="square"/>
<pad name="O5" x="-13.97" y="-3.81" drill="0.8" shape="square"/>
<pad name="O6" x="-13.97" y="-5.08" drill="0.8" shape="square"/>
<pad name="O7" x="-13.97" y="-6.35" drill="0.8" shape="square"/>
<pad name="O8" x="-13.97" y="-7.62" drill="0.8" shape="square"/>
<pad name="O_VCC" x="-12.7" y="1.27" drill="0.8" shape="square"/>
<pad name="O_GND" x="-11.43" y="1.27" drill="0.8" shape="square"/>
<pad name="A_VCC" x="-8.89" y="7.62" drill="0.8" shape="square"/>
<pad name="A_GND" x="-8.89" y="6.35" drill="0.8" shape="square"/>
<smd name="U$17-6" x="-11.43" y="-7.62" dx="1.27" dy="0.635" layer="1"/>
<smd name="U$17-5" x="-11.43" y="-6.35" dx="1.27" dy="0.635" layer="1"/>
<smd name="U$17-4" x="-11.43" y="-5.08" dx="1.27" dy="0.635" layer="1"/>
<smd name="U$17-3" x="-11.43" y="-3.81" dx="1.27" dy="0.635" layer="1"/>
<smd name="U$17-2" x="-11.43" y="-2.54" dx="1.27" dy="0.635" layer="1"/>
<smd name="U$17-1" x="-11.43" y="-1.27" dx="1.27" dy="0.635" layer="1"/>
<smd name="I2C_1" x="-8.89" y="-7.62" dx="1.27" dy="0.635" layer="1"/>
<smd name="I2C_2" x="-8.89" y="-6.35" dx="1.27" dy="0.635" layer="1"/>
<smd name="I2C_3" x="-8.89" y="-5.08" dx="1.27" dy="0.635" layer="1"/>
<smd name="I2C_4" x="-8.89" y="-3.81" dx="1.27" dy="0.635" layer="1"/>
<smd name="GPS_4" x="16.51" y="-7.62" dx="1.27" dy="0.635" layer="1" rot="R90"/>
<smd name="GPS_3" x="15.24" y="-7.62" dx="1.27" dy="0.635" layer="1" rot="R90"/>
<smd name="GPS_2" x="13.97" y="-7.62" dx="1.27" dy="0.635" layer="1" rot="R90"/>
<smd name="GPS_1" x="12.7" y="-7.62" dx="1.27" dy="0.635" layer="1" rot="R90"/>
<smd name="GPS_N_5" x="16.51" y="-5.08" dx="1.27" dy="0.635" layer="1" rot="R90"/>
<smd name="GPS_N_4" x="15.24" y="-5.08" dx="1.27" dy="0.635" layer="1" rot="R90"/>
<smd name="GPS_N_3" x="13.97" y="-5.08" dx="1.27" dy="0.635" layer="1" rot="R90"/>
<smd name="GPS_N_2" x="12.7" y="-5.08" dx="1.27" dy="0.635" layer="1" rot="R90"/>
<smd name="GPS_N_1" x="11.43" y="-5.08" dx="1.27" dy="0.635" layer="1" rot="R90"/>
<pad name="I1" x="16.51" y="-2.54" drill="0.8" shape="square"/>
<pad name="I2" x="16.51" y="-1.27" drill="0.8" shape="square"/>
<pad name="I3" x="16.51" y="0" drill="0.8" shape="square"/>
<pad name="I4" x="16.51" y="1.27" drill="0.8" shape="square"/>
<pad name="I5" x="16.51" y="2.54" drill="0.8" shape="square"/>
<pad name="I6" x="16.51" y="3.81" drill="0.8" shape="square"/>
<pad name="I7" x="16.51" y="5.08" drill="0.8" shape="square"/>
<pad name="I8" x="16.51" y="6.35" drill="0.8" shape="square"/>
<pad name="I_GND" x="15.24" y="-2.54" drill="0.8" shape="square"/>
<pad name="I_VDD" x="13.97" y="-2.54" drill="0.8" shape="square"/>
<pad name="P$25" x="10.16" y="8.89" drill="0.8" shape="square"/>
<pad name="P$26" x="11.43" y="8.89" drill="0.8" shape="square"/>
<pad name="P$28" x="11.43" y="7.62" drill="0.8" shape="square"/>
<pad name="P$27" x="10.16" y="7.62" drill="0.8" shape="square"/>
<pad name="P$29" x="10.16" y="6.35" drill="0.8" shape="square"/>
<pad name="P$30" x="11.43" y="6.35" drill="0.8" shape="square"/>
<pad name="A9" x="2.54" y="8.89" drill="0.8" shape="square"/>
<pad name="A10" x="3.81" y="8.89" drill="0.8" shape="square"/>
<pad name="A11" x="5.08" y="8.89" drill="0.8" shape="square"/>
<pad name="A12" x="6.35" y="8.89" drill="0.8" shape="square"/>
</package>
</packages>
<symbols>
<symbol name="ARDUCOPTER2.8">
<wire x1="-86.36" y1="20.32" x2="-86.36" y2="-25.4" width="0.254" layer="94"/>
<wire x1="-86.36" y1="-25.4" x2="17.78" y2="-25.4" width="0.254" layer="94"/>
<wire x1="17.78" y1="-25.4" x2="17.78" y2="20.32" width="0.254" layer="94"/>
<wire x1="17.78" y1="20.32" x2="-86.36" y2="20.32" width="0.254" layer="94"/>
<pin name="VCC_OUT" x="-91.44" y="5.08" length="middle"/>
<pin name="GND_OUT" x="-91.44" y="2.54" length="middle"/>
<pin name="OUT8" x="-91.44" y="-5.08" length="middle"/>
<pin name="OUT7" x="-91.44" y="-7.62" length="middle"/>
<pin name="OUT6" x="-91.44" y="-10.16" length="middle"/>
<pin name="OUT5" x="-91.44" y="-12.7" length="middle"/>
<pin name="OUT4" x="-91.44" y="-15.24" length="middle"/>
<pin name="OUT3" x="-91.44" y="-17.78" length="middle"/>
<pin name="OUT2" x="-91.44" y="-20.32" length="middle"/>
<pin name="OUT1" x="-91.44" y="-22.86" length="middle"/>
<pin name="VCC@1" x="-81.28" y="25.4" length="middle" rot="R270"/>
<pin name="TX1-O" x="-78.74" y="25.4" length="middle" rot="R270"/>
<pin name="RX1-I" x="-76.2" y="25.4" length="middle" rot="R270"/>
<pin name="NC@1" x="-73.66" y="25.4" length="middle" rot="R270"/>
<pin name="GND" x="-71.12" y="25.4" length="middle" rot="R270"/>
<pin name="VCC_A" x="-63.5" y="25.4" length="middle" rot="R270"/>
<pin name="GND_A" x="-60.96" y="25.4" length="middle" rot="R270"/>
<pin name="A1" x="-55.88" y="25.4" length="middle" rot="R270"/>
<pin name="A2" x="-53.34" y="25.4" length="middle" rot="R270"/>
<pin name="A3" x="-50.8" y="25.4" length="middle" rot="R270"/>
<pin name="A4" x="-48.26" y="25.4" length="middle" rot="R270"/>
<pin name="A5" x="-45.72" y="25.4" length="middle" rot="R270"/>
<pin name="A6" x="-43.18" y="25.4" length="middle" rot="R270"/>
<pin name="A7" x="-40.64" y="25.4" length="middle" rot="R270"/>
<pin name="A8" x="-38.1" y="25.4" length="middle" rot="R270"/>
<pin name="A9" x="-35.56" y="25.4" length="middle" rot="R270"/>
<pin name="A10" x="-33.02" y="25.4" length="middle" rot="R270"/>
<pin name="A11" x="-30.48" y="25.4" length="middle" rot="R270"/>
<pin name="A12" x="-27.94" y="25.4" length="middle" rot="R270"/>
<pin name="P$31" x="-22.86" y="25.4" length="middle" rot="R270"/>
<pin name="P$32" x="-20.32" y="25.4" length="middle" rot="R270"/>
<pin name="P$33" x="-17.78" y="25.4" length="middle" rot="R270"/>
<pin name="P$34" x="-15.24" y="25.4" length="middle" rot="R270"/>
<pin name="P$35" x="-12.7" y="25.4" length="middle" rot="R270"/>
<pin name="P$36" x="-10.16" y="25.4" length="middle" rot="R270"/>
<pin name="VCC_IN" x="22.86" y="17.78" length="middle" rot="R180"/>
<pin name="GND_IN" x="22.86" y="15.24" length="middle" rot="R180"/>
<pin name="IN8" x="22.86" y="10.16" length="middle" rot="R180"/>
<pin name="IN7" x="22.86" y="7.62" length="middle" rot="R180"/>
<pin name="IN6" x="22.86" y="5.08" length="middle" rot="R180"/>
<pin name="IN5" x="22.86" y="2.54" length="middle" rot="R180"/>
<pin name="IN4" x="22.86" y="0" length="middle" rot="R180"/>
<pin name="IN3" x="22.86" y="-2.54" length="middle" rot="R180"/>
<pin name="IN2" x="22.86" y="-5.08" length="middle" rot="R180"/>
<pin name="IN1" x="22.86" y="-7.62" length="middle" rot="R180"/>
<pin name="JP_VCC@1" x="-66.04" y="-30.48" length="middle" rot="R90"/>
<pin name="JP_VCC@2" x="-63.5" y="-30.48" length="middle" rot="R90"/>
<pin name="ADC12@3" x="-60.96" y="-30.48" length="middle" rot="R90"/>
<pin name="ADC13@4" x="-58.42" y="-30.48" length="middle" rot="R90"/>
<pin name="GND@5" x="-55.88" y="-30.48" length="middle" rot="R90"/>
<pin name="GND@6" x="-53.34" y="-30.48" length="middle" rot="R90"/>
<pin name="P$52" x="-45.72" y="-30.48" length="middle" rot="R90"/>
<pin name="P$53" x="-43.18" y="-30.48" length="middle" rot="R90"/>
<pin name="P$54" x="-40.64" y="-30.48" length="middle" rot="R90"/>
<pin name="P$55" x="-38.1" y="-30.48" length="middle" rot="R90"/>
<pin name="P$56" x="15.24" y="-30.48" length="middle" rot="R90"/>
<pin name="P$57" x="12.7" y="-30.48" length="middle" rot="R90"/>
<pin name="P$58" x="10.16" y="-30.48" length="middle" rot="R90"/>
<pin name="P$59" x="7.62" y="-30.48" length="middle" rot="R90"/>
<pin name="P$60" x="2.54" y="-30.48" length="middle" rot="R90"/>
<pin name="P$61" x="0" y="-30.48" length="middle" rot="R90"/>
<pin name="P$62" x="-2.54" y="-30.48" length="middle" rot="R90"/>
<pin name="P$63" x="-5.08" y="-30.48" length="middle" rot="R90"/>
<pin name="P$64" x="-7.62" y="-30.48" length="middle" rot="R90"/>
<text x="-83.82" y="10.16" size="1.778" layer="94" rot="R90">Telem</text>
<text x="15.24" y="12.7" size="1.778" layer="94" rot="R180">INPUTS</text>
<text x="-83.82" y="-2.54" size="1.778" layer="94">OUTPUTS</text>
<text x="-66.04" y="7.62" size="1.778" layer="94" rot="R90">ANALOG</text>
<text x="-68.58" y="-22.86" size="1.778" layer="94" rot="R90">PM</text>
<text x="-48.26" y="-22.86" size="1.778" layer="94" rot="R90">I2C</text>
<text x="-10.16" y="-22.86" size="1.778" layer="94" rot="R90">GPS</text>
</symbol>
<symbol name="BESC30-R1">
<wire x1="-12.7" y1="-7.62" x2="12.7" y2="-7.62" width="0.254" layer="94"/>
<wire x1="12.7" y1="-7.62" x2="12.7" y2="10.16" width="0.254" layer="94"/>
<wire x1="12.7" y1="10.16" x2="-12.7" y2="10.16" width="0.254" layer="94"/>
<wire x1="-12.7" y1="10.16" x2="-12.7" y2="-7.62" width="0.254" layer="94"/>
<pin name="12V_POS" x="-17.78" y="-5.08" length="middle"/>
<pin name="12V_NEG" x="-17.78" y="-2.54" length="middle"/>
<pin name="GND" x="-17.78" y="2.54" length="middle"/>
<pin name="PWM" x="-17.78" y="5.08" length="middle"/>
<pin name="DIR" x="-17.78" y="7.62" length="middle"/>
<pin name="RED" x="17.78" y="-2.54" length="middle" rot="R180"/>
<pin name="YELLOW" x="17.78" y="0" length="middle" rot="R180"/>
<pin name="BLACK" x="17.78" y="2.54" length="middle" rot="R180"/>
<text x="-12.7" y="-10.16" size="1.27" layer="94">&gt;NAME</text>
</symbol>
<symbol name="CY1220">
<wire x1="-30.48" y1="-10.16" x2="-30.48" y2="12.7" width="0.254" layer="94"/>
<wire x1="-30.48" y1="12.7" x2="15.24" y2="12.7" width="0.254" layer="94"/>
<wire x1="15.24" y1="12.7" x2="15.24" y2="-10.16" width="0.254" layer="94"/>
<wire x1="15.24" y1="-10.16" x2="-30.48" y2="-10.16" width="0.254" layer="94"/>
<pin name="PANEL_POS" x="-35.56" y="-2.54" length="middle"/>
<pin name="PANEL_NEG" x="-35.56" y="-5.08" length="middle"/>
<pin name="BATT_POS" x="-35.56" y="7.62" length="middle"/>
<pin name="BATT_NEG" x="-35.56" y="5.08" length="middle"/>
<pin name="12V_POS" x="20.32" y="-5.08" length="middle" rot="R180"/>
<pin name="12V_NEG" x="20.32" y="-7.62" length="middle" rot="R180"/>
<pin name="5V_A_POS" x="20.32" y="2.54" length="middle" rot="R180"/>
<pin name="5V_A_NEG" x="20.32" y="0" length="middle" rot="R180"/>
<pin name="5V_B_POS" x="20.32" y="10.16" length="middle" rot="R180"/>
<pin name="5V_B_NEG" x="20.32" y="7.62" length="middle" rot="R180"/>
<text x="-15.24" y="0" size="1.27" layer="94">CY1220</text>
<text x="-27.94" y="15.24" size="1.27" layer="94">&gt;NAME</text>
</symbol>
<symbol name="NTC-3000">
<wire x1="-17.78" y1="-12.7" x2="-17.78" y2="10.16" width="0.254" layer="94"/>
<wire x1="-17.78" y1="10.16" x2="20.32" y2="10.16" width="0.254" layer="94"/>
<wire x1="20.32" y1="10.16" x2="20.32" y2="-12.7" width="0.254" layer="94"/>
<wire x1="20.32" y1="-12.7" x2="-17.78" y2="-12.7" width="0.254" layer="94"/>
<pin name="VCC" x="-22.86" y="-10.16" length="middle"/>
<pin name="DCD" x="-22.86" y="-7.62" length="middle"/>
<pin name="DTR" x="-22.86" y="-5.08" length="middle"/>
<pin name="GND" x="-22.86" y="-2.54" length="middle"/>
<pin name="RXD" x="-22.86" y="0" length="middle"/>
<pin name="TXD" x="-22.86" y="2.54" length="middle"/>
<pin name="RTS" x="-22.86" y="5.08" length="middle"/>
<pin name="CTS" x="-22.86" y="7.62" length="middle"/>
<text x="-5.08" y="-10.16" size="1.778" layer="94" rot="R180">Pin1</text>
<text x="-5.08" y="7.62" size="1.778" layer="94" rot="R180">Pin8</text>
<text x="0" y="0" size="1.27" layer="94">NTC-3000</text>
</symbol>
<symbol name="XTWDUINO_NANO_3">
<wire x1="-25.4" y1="12.7" x2="-25.4" y2="-10.16" width="0.254" layer="94"/>
<wire x1="-25.4" y1="-10.16" x2="25.4" y2="-10.16" width="0.254" layer="94"/>
<wire x1="25.4" y1="-10.16" x2="25.4" y2="12.7" width="0.254" layer="94"/>
<wire x1="25.4" y1="12.7" x2="-25.4" y2="12.7" width="0.254" layer="94"/>
<pin name="ICSP1" x="-30.48" y="7.62" length="middle"/>
<pin name="ICSP2" x="-30.48" y="5.08" length="middle"/>
<pin name="ICSP3" x="-30.48" y="2.54" length="middle"/>
<pin name="ICSP4" x="-30.48" y="0" length="middle"/>
<pin name="ICSP5" x="-30.48" y="-2.54" length="middle"/>
<pin name="ICSP6" x="-30.48" y="-5.08" length="middle"/>
<pin name="D1/TX" x="-15.24" y="-15.24" length="middle" rot="R90"/>
<pin name="D0/RX" x="-12.7" y="-15.24" length="middle" rot="R90"/>
<pin name="RESET" x="-10.16" y="-15.24" length="middle" rot="R90"/>
<pin name="GND@1" x="-7.62" y="-15.24" length="middle" rot="R90"/>
<pin name="D2" x="-5.08" y="-15.24" length="middle" rot="R90"/>
<pin name="D3" x="-2.54" y="-15.24" length="middle" rot="R90"/>
<pin name="D4" x="0" y="-15.24" length="middle" rot="R90"/>
<pin name="D5" x="2.54" y="-15.24" length="middle" rot="R90"/>
<pin name="D6" x="5.08" y="-15.24" length="middle" rot="R90"/>
<pin name="D7" x="7.62" y="-15.24" length="middle" rot="R90"/>
<pin name="D8" x="10.16" y="-15.24" length="middle" rot="R90"/>
<pin name="D9" x="12.7" y="-15.24" length="middle" rot="R90"/>
<pin name="D10" x="15.24" y="-15.24" length="middle" rot="R90"/>
<pin name="D11" x="17.78" y="-15.24" length="middle" rot="R90"/>
<pin name="D12" x="20.32" y="-15.24" length="middle" rot="R90"/>
<pin name="D13" x="20.32" y="17.78" length="middle" rot="R270"/>
<pin name="3V3" x="17.78" y="17.78" length="middle" rot="R270"/>
<pin name="AREF" x="15.24" y="17.78" length="middle" rot="R270"/>
<pin name="A0" x="12.7" y="17.78" length="middle" rot="R270"/>
<pin name="A1" x="10.16" y="17.78" length="middle" rot="R270"/>
<pin name="A2" x="7.62" y="17.78" length="middle" rot="R270"/>
<pin name="A3" x="5.08" y="17.78" length="middle" rot="R270"/>
<pin name="A4" x="2.54" y="17.78" length="middle" rot="R270"/>
<pin name="A5" x="0" y="17.78" length="middle" rot="R270"/>
<pin name="A6" x="-2.54" y="17.78" length="middle" rot="R270"/>
<pin name="A7" x="-5.08" y="17.78" length="middle" rot="R270"/>
<pin name="+5V" x="-7.62" y="17.78" length="middle" rot="R270"/>
<pin name="RESET@2" x="-10.16" y="17.78" length="middle" rot="R270"/>
<pin name="GND@2" x="-12.7" y="17.78" length="middle" rot="R270"/>
<pin name="VIN" x="-15.24" y="17.78" length="middle" rot="R270"/>
<text x="0" y="0" size="1.27" layer="94">XTWduino Nanon 3.0</text>
</symbol>
<symbol name="HT12V3.3">
<wire x1="-17.78" y1="10.16" x2="20.32" y2="10.16" width="0.254" layer="94"/>
<wire x1="20.32" y1="10.16" x2="20.32" y2="-7.62" width="0.254" layer="94"/>
<wire x1="20.32" y1="-7.62" x2="-17.78" y2="-7.62" width="0.254" layer="94"/>
<wire x1="-17.78" y1="-7.62" x2="-17.78" y2="10.16" width="0.254" layer="94"/>
<pin name="POS" x="15.24" y="15.24" length="middle" rot="R270"/>
<pin name="NEG" x="17.78" y="15.24" length="middle" rot="R270"/>
<text x="-17.78" y="12.7" size="1.27" layer="94">&gt;NAME</text>
<text x="-15.24" y="7.62" size="1.27" layer="94">HT12V3.3</text>
</symbol>
<symbol name="MAX3232">
<wire x1="-17.78" y1="10.16" x2="-17.78" y2="-15.24" width="0.254" layer="94"/>
<wire x1="-17.78" y1="-15.24" x2="15.24" y2="-15.24" width="0.254" layer="94"/>
<wire x1="15.24" y1="-15.24" x2="15.24" y2="10.16" width="0.254" layer="94"/>
<wire x1="15.24" y1="10.16" x2="-17.78" y2="10.16" width="0.254" layer="94"/>
<pin name="DE9-1" x="20.32" y="7.62" length="middle" rot="R180"/>
<pin name="DE9-2" x="20.32" y="5.08" length="middle" rot="R180"/>
<pin name="DE9-3" x="20.32" y="2.54" length="middle" rot="R180"/>
<pin name="DE9-4" x="20.32" y="0" length="middle" rot="R180"/>
<pin name="DE9-5" x="20.32" y="-2.54" length="middle" rot="R180"/>
<pin name="DE9-6" x="20.32" y="-5.08" length="middle" rot="R180"/>
<pin name="DE9-7" x="20.32" y="-7.62" length="middle" rot="R180"/>
<pin name="DE9-8" x="20.32" y="-10.16" length="middle" rot="R180"/>
<pin name="DE9-9" x="20.32" y="-12.7" length="middle" rot="R180"/>
<pin name="VCC" x="-22.86" y="2.54" length="middle"/>
<pin name="TX" x="-22.86" y="0" length="middle"/>
<pin name="RX" x="-22.86" y="-2.54" length="middle"/>
<pin name="GND" x="-22.86" y="-5.08" length="middle"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="ARDUCOPTER2.8">
<gates>
<gate name="G$1" symbol="ARDUCOPTER2.8" x="35.56" y="0"/>
</gates>
<devices>
<device name="" package="ARDUCOPTER2.8">
<connects>
<connect gate="G$1" pin="A1" pad="A0"/>
<connect gate="G$1" pin="A10" pad="A9"/>
<connect gate="G$1" pin="A11" pad="A10"/>
<connect gate="G$1" pin="A12" pad="A11"/>
<connect gate="G$1" pin="A2" pad="A1"/>
<connect gate="G$1" pin="A3" pad="A2"/>
<connect gate="G$1" pin="A4" pad="A3"/>
<connect gate="G$1" pin="A5" pad="A4"/>
<connect gate="G$1" pin="A6" pad="A5"/>
<connect gate="G$1" pin="A7" pad="A6"/>
<connect gate="G$1" pin="A8" pad="A7"/>
<connect gate="G$1" pin="A9" pad="A8"/>
<connect gate="G$1" pin="ADC12@3" pad="U$17-3"/>
<connect gate="G$1" pin="ADC13@4" pad="U$17-4"/>
<connect gate="G$1" pin="GND" pad="U$20-5"/>
<connect gate="G$1" pin="GND@5" pad="U$17-5"/>
<connect gate="G$1" pin="GND@6" pad="U$17-6"/>
<connect gate="G$1" pin="GND_A" pad="A_GND"/>
<connect gate="G$1" pin="GND_IN" pad="I_GND"/>
<connect gate="G$1" pin="GND_OUT" pad="O_GND"/>
<connect gate="G$1" pin="IN1" pad="I1"/>
<connect gate="G$1" pin="IN2" pad="I2"/>
<connect gate="G$1" pin="IN3" pad="I3"/>
<connect gate="G$1" pin="IN4" pad="I4"/>
<connect gate="G$1" pin="IN5" pad="I5"/>
<connect gate="G$1" pin="IN6" pad="I6"/>
<connect gate="G$1" pin="IN7" pad="I7"/>
<connect gate="G$1" pin="IN8" pad="I8"/>
<connect gate="G$1" pin="JP_VCC@1" pad="U$17-1"/>
<connect gate="G$1" pin="JP_VCC@2" pad="U$17-2"/>
<connect gate="G$1" pin="NC@1" pad="U$20-4"/>
<connect gate="G$1" pin="OUT1" pad="O1"/>
<connect gate="G$1" pin="OUT2" pad="O2"/>
<connect gate="G$1" pin="OUT3" pad="O3"/>
<connect gate="G$1" pin="OUT4" pad="O4"/>
<connect gate="G$1" pin="OUT5" pad="O5"/>
<connect gate="G$1" pin="OUT6" pad="O6"/>
<connect gate="G$1" pin="OUT7" pad="O7"/>
<connect gate="G$1" pin="OUT8" pad="O8"/>
<connect gate="G$1" pin="P$31" pad="P$25"/>
<connect gate="G$1" pin="P$32" pad="P$26"/>
<connect gate="G$1" pin="P$33" pad="P$27"/>
<connect gate="G$1" pin="P$34" pad="P$28"/>
<connect gate="G$1" pin="P$35" pad="P$29"/>
<connect gate="G$1" pin="P$36" pad="P$30"/>
<connect gate="G$1" pin="P$52" pad="I2C_1"/>
<connect gate="G$1" pin="P$53" pad="I2C_2"/>
<connect gate="G$1" pin="P$54" pad="I2C_3"/>
<connect gate="G$1" pin="P$55" pad="I2C_4"/>
<connect gate="G$1" pin="P$56" pad="GPS_4"/>
<connect gate="G$1" pin="P$57" pad="GPS_3"/>
<connect gate="G$1" pin="P$58" pad="GPS_2"/>
<connect gate="G$1" pin="P$59" pad="GPS_1"/>
<connect gate="G$1" pin="P$60" pad="GPS_N_5"/>
<connect gate="G$1" pin="P$61" pad="GPS_N_4"/>
<connect gate="G$1" pin="P$62" pad="GPS_N_3"/>
<connect gate="G$1" pin="P$63" pad="GPS_N_2"/>
<connect gate="G$1" pin="P$64" pad="GPS_N_1"/>
<connect gate="G$1" pin="RX1-I" pad="U$20-3"/>
<connect gate="G$1" pin="TX1-O" pad="U$20-2"/>
<connect gate="G$1" pin="VCC@1" pad="U$20-1"/>
<connect gate="G$1" pin="VCC_A" pad="A_VCC"/>
<connect gate="G$1" pin="VCC_IN" pad="I_VDD"/>
<connect gate="G$1" pin="VCC_OUT" pad="O_VCC"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="BESC30-R1">
<gates>
<gate name="G$1" symbol="BESC30-R1" x="63.5" y="-10.16"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name="">
<attribute name="_EXTERNAL_" value=""/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="CY1220">
<gates>
<gate name="G$1" symbol="CY1220" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name="">
<attribute name="_EXTERNAL_" value="" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="NTC-3000">
<gates>
<gate name="G$1" symbol="NTC-3000" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name="">
<attribute name="_EXTERNAL_" value="" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="XTWDUINO_NANO_3">
<gates>
<gate name="G$1" symbol="XTWDUINO_NANO_3" x="48.26" y="-5.08"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name="">
<attribute name="_EXTERNAL_" value="" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="HT12V3.3">
<gates>
<gate name="G$1" symbol="HT12V3.3" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name="">
<attribute name="_EXTERNAL_" value="" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="MAX3232">
<gates>
<gate name="G$1" symbol="MAX3232" x="2.54" y="2.54"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name="">
<attribute name="_EXTERNAL_" value="" constant="no"/>
</technology>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
</libraries>
<attributes>
</attributes>
<variantdefs>
</variantdefs>
<classes>
<class number="0" name="default" width="0" drill="0">
</class>
</classes>
<parts>
<part name="U$1" library="parts" deviceset="ARDUCOPTER2.8" device=""/>
<part name="LEFT_ESC" library="parts" deviceset="BESC30-R1" device=""/>
<part name="RIGHT_ESC" library="parts" deviceset="BESC30-R1" device=""/>
<part name="PSU" library="parts" deviceset="CY1220" device=""/>
<part name="U$5" library="parts" deviceset="NTC-3000" device=""/>
<part name="U$6" library="parts" deviceset="XTWDUINO_NANO_3" device=""/>
<part name="BATT1" library="parts" deviceset="HT12V3.3" device=""/>
<part name="BATT2" library="parts" deviceset="HT12V3.3" device=""/>
<part name="BATT3" library="parts" deviceset="HT12V3.3" device=""/>
<part name="BATT4" library="parts" deviceset="HT12V3.3" device=""/>
<part name="U$4" library="parts" deviceset="MAX3232" device=""/>
</parts>
<sheets>
<sheet>
<plain>
</plain>
<instances>
<instance part="U$1" gate="G$1" x="63.5" y="43.18"/>
<instance part="LEFT_ESC" gate="G$1" x="180.34" y="66.04"/>
<instance part="RIGHT_ESC" gate="G$1" x="180.34" y="43.18"/>
<instance part="PSU" gate="G$1" x="-38.1" y="-15.24"/>
<instance part="U$5" gate="G$1" x="81.28" y="96.52"/>
<instance part="U$6" gate="G$1" x="-48.26" y="96.52"/>
<instance part="BATT1" gate="G$1" x="-127" y="63.5"/>
<instance part="BATT2" gate="G$1" x="-127" y="33.02"/>
<instance part="BATT3" gate="G$1" x="-127" y="2.54"/>
<instance part="BATT4" gate="G$1" x="-127" y="-25.4"/>
<instance part="U$4" gate="G$1" x="15.24" y="96.52"/>
</instances>
<busses>
</busses>
<nets>
<net name="N$1" class="0">
<segment>
<pinref part="BATT2" gate="G$1" pin="NEG"/>
<wire x1="-109.22" y1="48.26" x2="-96.52" y2="48.26" width="0.1524" layer="91"/>
<wire x1="-96.52" y1="48.26" x2="-96.52" y2="78.74" width="0.1524" layer="91"/>
<pinref part="BATT3" gate="G$1" pin="NEG"/>
<wire x1="-109.22" y1="17.78" x2="-96.52" y2="17.78" width="0.1524" layer="91"/>
<junction x="-96.52" y="48.26"/>
<pinref part="BATT4" gate="G$1" pin="NEG"/>
<wire x1="-96.52" y1="17.78" x2="-96.52" y2="48.26" width="0.1524" layer="91"/>
<wire x1="-109.22" y1="-10.16" x2="-96.52" y2="-10.16" width="0.1524" layer="91"/>
<wire x1="-96.52" y1="-10.16" x2="-96.52" y2="17.78" width="0.1524" layer="91"/>
<junction x="-96.52" y="17.78"/>
<pinref part="BATT1" gate="G$1" pin="NEG"/>
<wire x1="-96.52" y1="78.74" x2="-109.22" y2="78.74" width="0.1524" layer="91"/>
<pinref part="PSU" gate="G$1" pin="BATT_NEG"/>
<wire x1="-73.66" y1="-10.16" x2="-96.52" y2="-10.16" width="0.1524" layer="91"/>
<junction x="-96.52" y="-10.16"/>
</segment>
</net>
<net name="N$2" class="0">
<segment>
<pinref part="BATT2" gate="G$1" pin="POS"/>
<wire x1="-111.76" y1="48.26" x2="-111.76" y2="50.8" width="0.1524" layer="91"/>
<wire x1="-111.76" y1="50.8" x2="-99.06" y2="50.8" width="0.1524" layer="91"/>
<wire x1="-99.06" y1="50.8" x2="-99.06" y2="81.28" width="0.1524" layer="91"/>
<junction x="-99.06" y="50.8"/>
<pinref part="BATT4" gate="G$1" pin="POS"/>
<wire x1="-99.06" y1="20.32" x2="-99.06" y2="50.8" width="0.1524" layer="91"/>
<wire x1="-111.76" y1="-10.16" x2="-111.76" y2="-7.62" width="0.1524" layer="91"/>
<wire x1="-111.76" y1="-7.62" x2="-99.06" y2="-7.62" width="0.1524" layer="91"/>
<pinref part="BATT3" gate="G$1" pin="POS"/>
<wire x1="-111.76" y1="17.78" x2="-111.76" y2="20.32" width="0.1524" layer="91"/>
<wire x1="-111.76" y1="20.32" x2="-99.06" y2="20.32" width="0.1524" layer="91"/>
<wire x1="-99.06" y1="-7.62" x2="-99.06" y2="20.32" width="0.1524" layer="91"/>
<junction x="-99.06" y="20.32"/>
<pinref part="BATT1" gate="G$1" pin="POS"/>
<wire x1="-111.76" y1="78.74" x2="-111.76" y2="81.28" width="0.1524" layer="91"/>
<wire x1="-111.76" y1="81.28" x2="-99.06" y2="81.28" width="0.1524" layer="91"/>
<pinref part="PSU" gate="G$1" pin="BATT_POS"/>
<wire x1="-73.66" y1="-7.62" x2="-99.06" y2="-7.62" width="0.1524" layer="91"/>
<junction x="-99.06" y="-7.62"/>
</segment>
</net>
<net name="N$3" class="0">
<segment>
<pinref part="PSU" gate="G$1" pin="12V_NEG"/>
<wire x1="-17.78" y1="-22.86" x2="139.7" y2="-22.86" width="0.1524" layer="91"/>
<wire x1="139.7" y1="-22.86" x2="139.7" y2="40.64" width="0.1524" layer="91"/>
<wire x1="139.7" y1="40.64" x2="162.56" y2="40.64" width="0.1524" layer="91"/>
<wire x1="139.7" y1="40.64" x2="139.7" y2="63.5" width="0.1524" layer="91"/>
<junction x="139.7" y="40.64"/>
<pinref part="LEFT_ESC" gate="G$1" pin="12V_NEG"/>
<wire x1="139.7" y1="63.5" x2="162.56" y2="63.5" width="0.1524" layer="91"/>
<pinref part="RIGHT_ESC" gate="G$1" pin="12V_NEG"/>
</segment>
</net>
<net name="N$4" class="0">
<segment>
<pinref part="PSU" gate="G$1" pin="12V_POS"/>
<wire x1="-17.78" y1="-20.32" x2="137.16" y2="-20.32" width="0.1524" layer="91"/>
<pinref part="LEFT_ESC" gate="G$1" pin="12V_POS"/>
<wire x1="137.16" y1="60.96" x2="162.56" y2="60.96" width="0.1524" layer="91"/>
<pinref part="RIGHT_ESC" gate="G$1" pin="12V_POS"/>
<wire x1="137.16" y1="38.1" x2="162.56" y2="38.1" width="0.1524" layer="91"/>
<wire x1="137.16" y1="38.1" x2="137.16" y2="60.96" width="0.1524" layer="91"/>
<junction x="137.16" y="38.1"/>
<wire x1="137.16" y1="-20.32" x2="137.16" y2="38.1" width="0.1524" layer="91"/>
</segment>
</net>
<net name="5V" class="0">
<segment>
<pinref part="PSU" gate="G$1" pin="5V_B_POS"/>
<wire x1="-15.24" y1="-5.08" x2="-17.78" y2="-5.08" width="0.1524" layer="91"/>
<label x="-15.24" y="-5.08" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$6" gate="G$1" pin="VIN"/>
<wire x1="-63.5" y1="114.3" x2="-63.5" y2="119.38" width="0.1524" layer="91"/>
<label x="-63.5" y="116.84" size="1.778" layer="95" rot="R90"/>
</segment>
<segment>
<pinref part="U$5" gate="G$1" pin="VCC"/>
<wire x1="58.42" y1="86.36" x2="53.34" y2="86.36" width="0.1524" layer="91"/>
<label x="53.34" y="86.36" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$1" gate="G$1" pin="JP_VCC@2"/>
<pinref part="U$1" gate="G$1" pin="JP_VCC@1"/>
<wire x1="0" y1="12.7" x2="-2.54" y2="12.7" width="0.1524" layer="91"/>
<wire x1="-2.54" y1="12.7" x2="-2.54" y2="5.08" width="0.1524" layer="91"/>
<junction x="-2.54" y="12.7"/>
<label x="-2.54" y="5.08" size="1.778" layer="95" rot="R90"/>
</segment>
<segment>
<pinref part="U$4" gate="G$1" pin="VCC"/>
<wire x1="-7.62" y1="99.06" x2="-12.7" y2="99.06" width="0.1524" layer="91"/>
<label x="-12.7" y="99.06" size="1.778" layer="95"/>
</segment>
</net>
<net name="GND" class="0">
<segment>
<pinref part="PSU" gate="G$1" pin="5V_B_NEG"/>
<wire x1="-17.78" y1="-7.62" x2="-12.7" y2="-7.62" width="0.1524" layer="91"/>
<label x="-15.24" y="-7.62" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$6" gate="G$1" pin="GND@1"/>
<wire x1="-55.88" y1="81.28" x2="-55.88" y2="76.2" width="0.1524" layer="91"/>
<label x="-55.88" y="76.2" size="1.778" layer="95" rot="R90"/>
</segment>
<segment>
<pinref part="U$6" gate="G$1" pin="GND@2"/>
<wire x1="-60.96" y1="114.3" x2="-60.96" y2="119.38" width="0.1524" layer="91"/>
<label x="-60.96" y="116.84" size="1.778" layer="95" rot="R90"/>
</segment>
<segment>
<pinref part="U$4" gate="G$1" pin="GND"/>
<wire x1="-7.62" y1="91.44" x2="-10.16" y2="91.44" width="0.1524" layer="91"/>
<label x="-10.16" y="91.44" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$5" gate="G$1" pin="GND"/>
<wire x1="58.42" y1="93.98" x2="53.34" y2="93.98" width="0.1524" layer="91"/>
<label x="53.34" y="93.98" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="LEFT_ESC" gate="G$1" pin="GND"/>
<wire x1="162.56" y1="68.58" x2="154.94" y2="68.58" width="0.1524" layer="91"/>
<label x="154.94" y="68.58" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="RIGHT_ESC" gate="G$1" pin="GND"/>
<wire x1="162.56" y1="45.72" x2="154.94" y2="45.72" width="0.1524" layer="91"/>
<label x="154.94" y="45.72" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$1" gate="G$1" pin="GND@5"/>
<pinref part="U$1" gate="G$1" pin="GND@6"/>
<wire x1="7.62" y1="12.7" x2="10.16" y2="12.7" width="0.1524" layer="91"/>
<wire x1="10.16" y1="12.7" x2="10.16" y2="5.08" width="0.1524" layer="91"/>
<junction x="10.16" y="12.7"/>
<label x="10.16" y="5.08" size="1.778" layer="95" rot="R90"/>
</segment>
</net>
<net name="N$5" class="0">
<segment>
<pinref part="U$4" gate="G$1" pin="DE9-1"/>
<wire x1="35.56" y1="104.14" x2="38.1" y2="104.14" width="0.1524" layer="91"/>
<wire x1="38.1" y1="104.14" x2="50.8" y2="88.9" width="0.1524" layer="91"/>
<pinref part="U$5" gate="G$1" pin="DCD"/>
<wire x1="50.8" y1="88.9" x2="58.42" y2="88.9" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$6" class="0">
<segment>
<pinref part="U$4" gate="G$1" pin="DE9-2"/>
<wire x1="35.56" y1="101.6" x2="45.72" y2="101.6" width="0.1524" layer="91"/>
<wire x1="45.72" y1="101.6" x2="48.26" y2="99.06" width="0.1524" layer="91"/>
<pinref part="U$5" gate="G$1" pin="TXD"/>
<wire x1="48.26" y1="99.06" x2="58.42" y2="99.06" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$7" class="0">
<segment>
<pinref part="U$4" gate="G$1" pin="DE9-3"/>
<wire x1="35.56" y1="99.06" x2="45.72" y2="99.06" width="0.1524" layer="91"/>
<wire x1="45.72" y1="99.06" x2="48.26" y2="96.52" width="0.1524" layer="91"/>
<pinref part="U$5" gate="G$1" pin="RXD"/>
<wire x1="48.26" y1="96.52" x2="58.42" y2="96.52" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$8" class="0">
<segment>
<pinref part="U$4" gate="G$1" pin="DE9-4"/>
<wire x1="35.56" y1="96.52" x2="45.72" y2="96.52" width="0.1524" layer="91"/>
<pinref part="U$5" gate="G$1" pin="DTR"/>
<wire x1="58.42" y1="91.44" x2="50.8" y2="91.44" width="0.1524" layer="91"/>
<wire x1="50.8" y1="91.44" x2="45.72" y2="96.52" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$9" class="0">
<segment>
<pinref part="U$4" gate="G$1" pin="DE9-7"/>
<wire x1="35.56" y1="88.9" x2="40.64" y2="88.9" width="0.1524" layer="91"/>
<wire x1="40.64" y1="88.9" x2="53.34" y2="101.6" width="0.1524" layer="91"/>
<pinref part="U$5" gate="G$1" pin="RTS"/>
<wire x1="53.34" y1="101.6" x2="58.42" y2="101.6" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$10" class="0">
<segment>
<pinref part="U$4" gate="G$1" pin="DE9-8"/>
<wire x1="35.56" y1="86.36" x2="38.1" y2="86.36" width="0.1524" layer="91"/>
<wire x1="38.1" y1="86.36" x2="38.1" y2="88.9" width="0.1524" layer="91"/>
<wire x1="38.1" y1="88.9" x2="53.34" y2="104.14" width="0.1524" layer="91"/>
<pinref part="U$5" gate="G$1" pin="CTS"/>
<wire x1="53.34" y1="104.14" x2="58.42" y2="104.14" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$12" class="0">
<segment>
<pinref part="U$4" gate="G$1" pin="RX"/>
<wire x1="-7.62" y1="93.98" x2="-12.7" y2="93.98" width="0.1524" layer="91"/>
<wire x1="-12.7" y1="93.98" x2="-12.7" y2="76.2" width="0.1524" layer="91"/>
<wire x1="-12.7" y1="76.2" x2="-53.34" y2="76.2" width="0.1524" layer="91"/>
<pinref part="U$6" gate="G$1" pin="D2"/>
<wire x1="-53.34" y1="76.2" x2="-53.34" y2="81.28" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$13" class="0">
<segment>
<pinref part="U$4" gate="G$1" pin="TX"/>
<wire x1="-7.62" y1="96.52" x2="-15.24" y2="96.52" width="0.1524" layer="91"/>
<wire x1="-15.24" y1="96.52" x2="-15.24" y2="78.74" width="0.1524" layer="91"/>
<wire x1="-15.24" y1="78.74" x2="-50.8" y2="78.74" width="0.1524" layer="91"/>
<pinref part="U$6" gate="G$1" pin="D3"/>
<wire x1="-50.8" y1="78.74" x2="-50.8" y2="81.28" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$15" class="0">
<segment>
<pinref part="RIGHT_ESC" gate="G$1" pin="DIR"/>
<wire x1="162.56" y1="50.8" x2="154.94" y2="50.8" width="0.1524" layer="91"/>
<label x="149.86" y="50.8" size="1.778" layer="95"/>
</segment>
</net>
<net name="N$18" class="0">
<segment>
<pinref part="LEFT_ESC" gate="G$1" pin="DIR"/>
<wire x1="162.56" y1="73.66" x2="154.94" y2="73.66" width="0.1524" layer="91"/>
<label x="149.86" y="73.66" size="1.778" layer="95"/>
</segment>
</net>
<net name="LEFT_PWM" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="OUT1"/>
<wire x1="-27.94" y1="20.32" x2="-38.1" y2="20.32" width="0.1524" layer="91"/>
<label x="-45.72" y="20.32" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="LEFT_ESC" gate="G$1" pin="PWM"/>
<wire x1="162.56" y1="71.12" x2="154.94" y2="71.12" width="0.1524" layer="91"/>
<label x="149.86" y="71.12" size="1.778" layer="95"/>
</segment>
</net>
<net name="RIGHT_PWM" class="0">
<segment>
<pinref part="U$1" gate="G$1" pin="OUT3"/>
<wire x1="-27.94" y1="25.4" x2="-38.1" y2="25.4" width="0.1524" layer="91"/>
<label x="-45.72" y="25.4" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="RIGHT_ESC" gate="G$1" pin="PWM"/>
<wire x1="162.56" y1="48.26" x2="154.94" y2="48.26" width="0.1524" layer="91"/>
<label x="149.86" y="48.26" size="1.778" layer="95"/>
</segment>
</net>
<net name="N$11" class="0">
<segment>
<pinref part="U$6" gate="G$1" pin="D1/TX"/>
<wire x1="-63.5" y1="81.28" x2="-63.5" y2="73.66" width="0.1524" layer="91"/>
<wire x1="-63.5" y1="73.66" x2="-12.7" y2="73.66" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="RX1-I"/>
<wire x1="-12.7" y1="73.66" x2="-12.7" y2="68.58" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$14" class="0">
<segment>
<pinref part="U$6" gate="G$1" pin="D0/RX"/>
<wire x1="-60.96" y1="81.28" x2="-60.96" y2="71.12" width="0.1524" layer="91"/>
<wire x1="-60.96" y1="71.12" x2="-15.24" y2="71.12" width="0.1524" layer="91"/>
<pinref part="U$1" gate="G$1" pin="TX1-O"/>
<wire x1="-15.24" y1="71.12" x2="-15.24" y2="68.58" width="0.1524" layer="91"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
</schematic>
</drawing>
</eagle>
