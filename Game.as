package {
	
	/**
	 *  Developer: Alok Mishra
	 * 
	 * 
	 *  Dt: 13 Sept 2013
	 * 
	 *  Objective: Create an auto playing 5x5 card bejeweled game.
	 * 
	 */
	
	import flash.display.*;
	import flash.events.*;
	import flash.text.TextField;
	import flash.utils.Timer;
	import com.greensock.*; 
	import com.greensock.easing.*;	
	

	/**
	* The document class
	* 
	*/

	public class Game extends MovieClip {
		
		//Some constants based on the bg asset size
		var startx:int = 153;
		var starty:int = 47;
		var width_space:int = 100;
		var height_space:int = 70;
		
		var map:Array = new Array(); //Main 2D array, holds the matrix throughout
		var reousrcestimer:Timer;
		var itemdisappeartimer:Timer;
		var disappeartimer:Timer;
		var earned:TextField;
		var first:Boolean = true;
		var stopped:Boolean = true;
		var matchedh:int = 0;
		var matchedv:int = 0;
		var ctr:int = 0;
		
		//---------------------------------------
		// CONSTRUCTOR
		//---------------------------------------
		public function Game():void
		{
			(this.getChildByName("inst") as TextField).visible = false;
			
			(this.getChildByName("startbut") as SimpleButton).addEventListener(MouseEvent.CLICK, startGameAuto, false, 0, true);	
			
		}
		
		private function populateJewels(st_i:int, end_i:int, st_j:int, end_j:int):void
		{
			
			for (var i:int = st_i; i < end_i; i++) 
			{			
				map[i] = new Array();
				for (var j:int = st_j; j < end_j; j++) 
				{
					map[i][j] = { no:Math.round(Math.random() * 100) };
					
				}
			}		
			
			jewelLogic(st_i, end_i, st_j, end_j,"h");	
		}
		
		private function jewelLogic(st_i:int, end_i:int, st_j:int, end_j:int,s:String):void
		{
			//0-24, 75-80 Blue, 25-49, 81-85 Brown, 50-74, 86-90 Red, 91-100 Wild
			
			if (s == "h")
			{
				for (var i:int = st_i; i < end_i; i++) 
				{			
					for (var j:int = st_j; j < end_j; j++) 
					{
						//Blue
						if ((int((map[i][j]).no) >= 0 && int((map[i][j]).no) <= 24) || (int((map[i][j]).no) >= 75 && int((map[i][j]).no) <= 80))
						{
							var blue:Blue_holder = new Blue_holder();
							this.addChild(blue);
							TweenMax.to(blue, 2, {glowFilter:{color:0x91e600, alpha:1, blurX:30, blurY:30, strength:2, quality:2, remove:true}, ease:Back.easeOut});
							blue.x = startx + (width_space*j);
							blue.y = starty + (height_space * i);
							(map[i][j]).jewel = "blue";
							(map[i][j]).ref = blue;
						}
						//Brown
						if ((int((map[i][j]).no) >= 25 && int((map[i][j]).no) <= 49) || (int((map[i][j]).no) >= 81 && int((map[i][j]).no) <= 85))
						{
							var brown:Brown_holder = new Brown_holder();
							this.addChild(brown);
							TweenMax.to(brown, 2, {glowFilter:{color:0x91e600, alpha:1, blurX:30, blurY:30, strength:2, quality:2, remove:true}, ease:Back.easeOut});
							brown.x = startx + (width_space*j);
							brown.y = starty + (height_space * i);
							(map[i][j]).jewel = "brown";
							(map[i][j]).ref = brown;
						}
						//Red
						if ((int((map[i][j]).no) >= 50 && int((map[i][j]).no) <= 74) || (int((map[i][j]).no) >= 86 && int((map[i][j]).no) <= 90))
						{
							var red:Red_holder = new Red_holder();
							this.addChild(red);
							TweenMax.to(red,2, {glowFilter:{color:0x91e600, alpha:1, blurX:30, blurY:30, strength:2, quality:2, remove:true}, ease:Back.easeOut});
							red.x = startx + (width_space*j);
							red.y = starty + (height_space * i);	
							(map[i][j]).jewel = "red";
							(map[i][j]).ref = red;
						}
						//Wild
						if (int((map[i][j]).no) >= 91 && int((map[i][j]).no) <= 100)
						{
							var wild:Wild_holder = new Wild_holder();
							this.addChild(wild);
							TweenMax.to(wild, 2, {glowFilter:{color:0x91e600, alpha:1, blurX:30, blurY:30, strength:2, quality:2, remove:true}, ease:Back.easeOut});
							wild.x = startx + (width_space*j);
							wild.y = starty + (height_space * i);	
							(map[i][j]).jewel = "wild";
							(map[i][j]).ref = wild;
						}					
						
					}
					
				}
				if (first == false)
				{
					reousrcestimer = new Timer(2000, 1);
					reousrcestimer.addEventListener(TimerEvent.TIMER, listenonresources("h"));
					reousrcestimer.start();						
				}
			}
			if (s == "v")
			{
				for (var j:int = st_j; j <= end_j; j++)  
				{			
					for (var i:int = st_i; i <= end_i; i++) 
					{
						//Blue
						if ((int((map[i][j]).no) >= 0 && int((map[i][j]).no) <= 24) || (int((map[i][j]).no) >= 75 && int((map[i][j]).no) <= 80))
						{
							var blue:Blue_holder = new Blue_holder();
							this.addChild(blue);
							TweenMax.to(blue, 2, {glowFilter:{color:0x91e600, alpha:1, blurX:30, blurY:30, strength:2, quality:2, remove:true}, ease:Back.easeOut});
							blue.x = startx + (width_space*j);
							blue.y = starty + (height_space * i);
							(map[i][j]).jewel = "blue";
							(map[i][j]).ref = blue;
						}
						//Brown
						if ((int((map[i][j]).no) >= 25 && int((map[i][j]).no) <= 49) || (int((map[i][j]).no) >= 81 && int((map[i][j]).no) <= 85))
						{
							var brown:Brown_holder = new Brown_holder();
							this.addChild(brown);
							TweenMax.to(brown, 2, {glowFilter:{color:0x91e600, alpha:1, blurX:30, blurY:30, strength:2, quality:2, remove:true}, ease:Back.easeOut});
							brown.x = startx + (width_space*j);
							brown.y = starty + (height_space * i);
							(map[i][j]).jewel = "brown";
							(map[i][j]).ref = brown;
						}
						//Red
						if ((int((map[i][j]).no) >= 50 && int((map[i][j]).no) <= 74) || (int((map[i][j]).no) >= 86 && int((map[i][j]).no) <= 90))
						{
							var red:Red_holder = new Red_holder();
							this.addChild(red);
							TweenMax.to(red,2, {glowFilter:{color:0x91e600, alpha:1, blurX:30, blurY:30, strength:2, quality:2, remove:true}, ease:Back.easeOut});
							red.x = startx + (width_space*j);
							red.y = starty + (height_space * i);	
							(map[i][j]).jewel = "red";
							(map[i][j]).ref = red;
						}
						//Wild
						if (int((map[i][j]).no) >= 91 && int((map[i][j]).no) <= 100)
						{
							var wild:Wild_holder = new Wild_holder();
							this.addChild(wild);
							TweenMax.to(wild, 2, {glowFilter:{color:0x91e600, alpha:1, blurX:30, blurY:30, strength:2, quality:2, remove:true}, ease:Back.easeOut});
							wild.x = startx + (width_space*j);
							wild.y = starty + (height_space * i);	
							(map[i][j]).jewel = "wild";
							(map[i][j]).ref = wild;
						}					
						
					}
					
				}
				if (first == false)
				{
					reousrcestimer = new Timer(2000, 1);
					reousrcestimer.addEventListener(TimerEvent.TIMER, listenonresources("v"));
					reousrcestimer.start();						
				}				
			}
			
			
			
		}
		
		//Main Game loop
		private function startGameAuto(event:MouseEvent = null):void
		{
			if (earned != null && this.contains(earned))
			{
				this.removeChild(earned);
			}				
			ctr = 0;
			stopped = false;		
			(this.getChildByName("startbut") as SimpleButton).removeEventListener(MouseEvent.CLICK, startGameAuto);	
			(this.getChildByName("startbut") as SimpleButton).visible = false;
			(this.getChildByName("stopbut") as SimpleButton).visible = true;
			if (this.getChildByName("startit") != null)
			{
				this.removeChild(this.getChildByName("startit"));
			}
			if (first)
			{
				(this.getChildByName("inst") as TextField).visible = true;
				populateJewels(0, 5, 0, 5);
				first = false;				
			}
			if (first == false)
			{
				for (var i:int = 0; i < 5; i++) 
				{		
					for (var j:int = 0; j < 5; j++) 
					{	
						if (map[i][j].ref != null)
						{
							map[i][j].ref.removeEventListener(MouseEvent.CLICK, swapWithWild);
						}
					}
				}
			}
			matchJewels();
			(this.getChildByName("stopbut") as SimpleButton).addEventListener(MouseEvent.CLICK, gameStop, false, 0, true);
			
		}
		
		private function gameStop(event:MouseEvent = null):void
		{
			if (earned != null && this.contains(earned))
			{
				this.removeChild(earned);
			}			
			reousrcestimer = null;
			disappeartimer = null;
			stopped = true;
			(this.getChildByName("stopbut") as SimpleButton).removeEventListener(MouseEvent.CLICK, gameStop);	
			(this.getChildByName("stopbut") as SimpleButton).visible = false;
			(this.getChildByName("startbut") as SimpleButton).visible = true;
			(this.getChildByName("startbut") as SimpleButton).addEventListener(MouseEvent.CLICK, startGameAuto, false, 0, true);
			for (var i:int = 0; i < 5; i++) 
			{		
				for (var j:int = 0; j < 5; j++) 
				{
					if (map[i][j].ref != null)
					{
						map[i][j].ref.removeEventListener(MouseEvent.CLICK, swapWithWild);
						map[i][j].ref.saved = map[i][j];
						map[i][j].ref.addEventListener(MouseEvent.CLICK, swapWithWild);						
					}
				}
			}			
		}
		
		private function swapWithWild(e:MouseEvent):void
		{
			if (ctr <= 2)
			{
				
				ctr++;
				var clicked:MovieClip = e.currentTarget as MovieClip;
				var par:Object = e.currentTarget.saved as Object;
				var wild:Wild_holder = new Wild_holder();
				this.addChild(wild);
				TweenMax.to(wild, 1, {glowFilter:{color:0x91e600, alpha:1, blurX:30, blurY:30, strength:2, quality:2, remove:true}, ease:Back.easeOut});
				wild.x = clicked.x;
				wild.y = clicked.y;	

				par.jewel = "wild";
				par.ref = wild;
				this.removeChild(clicked);
				clicked = null;			
			}
			else
			{
				if (earned != null && this.contains(earned))
				{
					this.removeChild(earned);
				}
				earned = new TextField();
				earned.text = "You have already clicked thrice!";
				this.addChild(earned);
				var clicked:MovieClip = e.currentTarget as MovieClip;
				earned.x = clicked.x - 50;
				earned.y = clicked.y;
				earned.background = true;
				earned.backgroundColor = 0xFFFFFF;
				earned.height = 40;
				earned.width = 200;	
				itemdisappeartimer = new Timer(2000,0);
				itemdisappeartimer.addEventListener(TimerEvent.TIMER,item);
				itemdisappeartimer.start();				
			}
			
		}
		
		private function item(evt:TimerEvent)
		{
			disappeartimer = new Timer(100,20);
			disappeartimer.addEventListener(TimerEvent.TIMER, removeitem);
			disappeartimer.start();
		}		
		
		function removeitem(evt:TimerEvent)
		{
			var motioncount:int = 0;
			motioncount++;
			earned.y -= 1;
			earned.alpha *= .8;
			if (motioncount == 20)
			{
				if (earned != null && this.contains(earned))
				{
					this.removeChild(earned);
				}
				itemdisappeartimer.removeEventListener(TimerEvent.TIMER, item);				
				itemdisappeartimer.stop();
			}
			
		}		
		
		private function fillJewels(st_i:int, end_i:int, st_j:int, end_j:int, s):void
		{
			if (s == "h")
			{
				for (var i:int = st_i; i <= end_i; i++)
				{			
					for (var j:int = st_j; j <= end_j; j++)
					{
						map[i][j] = {no:Math.round(Math.random() * 100)};
						
					}
				}
				jewelLogic(st_i, end_i + 1, st_j, end_j + 1,s);
				
			}
			//Vertical
			if (s == "v")
			{
				for (var j:int = st_j; j <= end_j; j++)
				{			
					for (var i:int = st_i; i <= end_i; i++)
					{
						map[i][j] = {no:Math.round(Math.random() * 100)};
					}
				}
				jewelLogic(st_i, end_i ,st_j, end_j,s);
				
			}					
		}		
		
		private function listenonresources(s:String):Function {
		  return function(e:TimerEvent):void {
			  reousrcestimer = null;
			  if (s == "h")
			  {
				horz();
			  }
			  else
			  {
				vert();
			  }
		  };
		}			
		
		
		private function matchJewels(e:Event = null):void
		{
			disappeartimer = null;
			if (stopped == false)
			{
				horz();							
			}						
			
			//gameStop();
		}		
		
		private function callv(e:Event)
		{
			disappeartimer = null;
			if (stopped == false)
			{
				vert();				
			}
		}
		
		private function horz() 
		{
			if (stopped == false)//horizontal 
			{
				var s:String = "h";
				var i1:int, i2:int, j1:int, j2:int;
				var hmatchctr:int = 0, basejewel:Object;
				for (var i:int = 0; i < 5; i++) 
				{		
					hmatchctr = 0; basejewel = { };
					for (var j:int = 0; j < 5; j++) 
					{
						if (hmatchctr == 0 && j != 4)
						{
							if ((map[i][j]).jewel == "wild")
							{
								if (j == 0 && (map[i][j+1]) != null && (map[i][j+1]).jewel != "wild")
								{
									basejewel = map[i][j+1];
									i1 = i;
									j1 = j;		
									hmatchctr = 0;
								}
								if (j == 0 && (map[i][j+1]) != null && (map[i][j+1]).jewel == "wild" && (map[i][j+2]) != null && (map[i][j+2]).jewel != "wild")
								{
									i1 = i;
									j1 = j;
									i2 = i;
									j2 = j + 2;	
									for (var v:int = i1; v <= i2; v++) //columns
									{			
										for (var w:int = j1; w <= j2; w++)  // rows
										{	
											TweenMax.to(map[v][w].ref, 2, { blurFilter: { blurX:80, blurY:80, quality:3 }, ease:Quad.easeInOut } );
											this.removeChild(map[v][w].ref);
										}
									}
									hmatchctr = 0;
									if (i1 == 0 && i2 == 0)//top row
									{
										fillJewels(i1, i2, j1, j2, s);
									}
									else
									{
										//Bring in new rows from top
										swapJewels(i1, i2, j1, j2,s);			
									}
									return;		
								}
							}
							else
							{
								basejewel = map[i][j];
								i1 = i;
								j1 = j;							
							}
						}
						if ((map[i][j]).jewel == "wild")
						{
							if (j != 4 && (map[i][j+1]) != null && (map[i][j+1]).jewel != basejewel.jewel && basejewel.jewel != "wild")
							{
								if (hmatchctr == 1 && map[i][j+1].jewel != "wild")
								{
									hmatchctr = 0;
									basejewel = map[i][j+1];
									i1 = i;
									j1 = j;								
								}
							}						
						}
						hmatchctr++;
						if (hmatchctr == 3 && ((j == 2) || (j == 3)))//spl case of 3-5
						{
							if ((map[i][j+1]).jewel == basejewel.jewel || (map[i][j+1]).jewel == "wild" || basejewel.jewel == "wild")
							{
								i2 = i;
								j2 = j + 1;
								if (j != 3)
								{
									if ((map[i][j + 2]).jewel == basejewel.jewel || (map[i][j + 2]).jewel == "wild" || basejewel.jewel == "wild")
									{
										i2 = i;
										j2 = j + 2;										
									}
								}								
								
							}							
							for (var v:int = i1; v <= i2; v++) //columns
							{			
								for (var w:int = j1; w <= j2; w++)  // rows
								{	
									TweenMax.to(map[v][w].ref, 2, { blurFilter: { blurX:80, blurY:80, quality:3 }, ease:Quad.easeInOut } );
									this.removeChild(map[v][w].ref);
								}
							}
							hmatchctr = 0;
							if (i1 == 0 && i2 == 0)//top row
							{
								fillJewels(i1, i2, j1, j2, s);
							}
							else
							{
								//Bring in new rows from top
								swapJewels(i1, i2, j1, j2,s);			
							}
							return;
						}						
						if (j == 4) //end of row
						{
							if (hmatchctr >= 3)
							{
								for (var v:int = i1; v <= i2; v++)
								{			
									for (var w:int = j1; w <= j2; w++)
									{	
										TweenMax.to(map[v][w].ref, 2, { blurFilter: { blurX:80, blurY:80, quality:3 }, ease:Quad.easeInOut } );
										this.removeChild(map[v][w].ref);
									}
								}
								if (i1 == 0 && i2 == 0)//top row
								{
									fillJewels(i1, i2, j1, j2, s);
								}
								else
								{
									//Bring in new rows from top
									swapJewels(i1, i2, j1, j2,s);			
								}
								return;
								
							}
						}
						else
						{
							//Horizontal
							if ((map[i][j+1]).jewel == basejewel.jewel || (map[i][j+1]).jewel == "wild" || basejewel.jewel == "wild")
							{
								i2 = i;
								j2 = j+1;
							}
							else
							{
								hmatchctr = 0;
								basejewel = null;
							}						
						}
					}
				}
				if (stopped == false)
				{
					disappeartimer = new Timer(2000, 1);
					disappeartimer.addEventListener(TimerEvent.TIMER, callv, false, 0, true);
					disappeartimer.start();						
				}
			}					
		}		
		
		private function vert() 
		{
			//Vertical matching
			if (stopped == false)
			{
				var s:String = "v";
				var p1:int, p2:int, q1:int, q2:int;
				var vmatchctr:int = 0, vbasejewel:Object;
				for (var p:int = 0; p < 5; p++) 
				{		
					vmatchctr = 0; vbasejewel = { };
					for (var q:int = 0; q < 5; q++) 
					{
						if (vmatchctr == 0 && q != 4)
						{
							if ((map[q][p]).jewel == "wild")
							{
								if (q == 0 && (map[q+1][p]) != null && (map[q+1][p]).jewel != "wild")
								{
									vbasejewel = map[q+1][p];
									p1 = q;
									q1 = p;		
									vmatchctr = 0;
								}
								if (q == 0 && (map[q + 1][p]) != null && (map[q + 1][p]).jewel == "wild" && (map[q + 2][p]) != null && (map[q + 2][p]).jewel != "wild")
								{
									p1 = q;
									q1 = p;	
									p2 = q + 2;
									q2 = p;
									for (var v:int = q1; v <= q2; v++)
									{			
										for (var w:int = p1; w <= p2; w++)
										{	
											TweenMax.to(map[w][v].ref, 2, { blurFilter: { blurX:80, blurY:80, quality:3 }, ease:Quad.easeInOut } );
											this.removeChild(map[w][v].ref);
										}
									}
									vmatchctr = 0;
									//Bring in new rows from top
									swapJewels(p1, p2, q1, q2,s);							
									return;									
								}
							}
							else
							{
								vbasejewel = map[q][p];
								p1 = q;
								q1 = p;							
							}							
						
						}			
						if ((map[q][p]).jewel == "wild")
						{
							if (q != 4 && (map[q+1][p]) != null && (map[q+1][p]).jewel != vbasejewel.jewel && vbasejewel.jewel != "wild")
							{
								if (vmatchctr == 1 && map[q+1][p].jewel != "wild")
								{
									vmatchctr = 0;
									vbasejewel = map[q+1][p];
									p1 = q;
									q1 = p;								
								}
							}						
						}						
						vmatchctr++;
						if (vmatchctr == 3 && ((q == 2) || (q == 3)))//spl case of 3-5
						{
							if ((map[q+1][p]).jewel == vbasejewel.jewel || (map[q+1][p]).jewel == "wild" || vbasejewel.jewel == "wild")
							{
								p2 = q+1;
								q2 = p;
								if (q != 3)
								{
									if ((map[q + 2][p]).jewel == vbasejewel.jewel || (map[q + 2][p]).jewel == "wild" || vbasejewel.jewel == "wild")
									{
										p2 = q+2;
										q2 = p;										
									}
							
								}
								
							}							
							for (var v:int = q1; v <= q2; v++)
							{			
								for (var w:int = p1; w <= p2; w++)
								{	
									TweenMax.to(map[w][v].ref, 2, { blurFilter: { blurX:80, blurY:80, quality:3 }, ease:Quad.easeInOut } );
									this.removeChild(map[w][v].ref);
								}
							}
							vmatchctr = 0;
							//Bring in new rows from top
							swapJewels(p1, p2, q1, q2,s);							
							return;
						}	
						if (q == 4) //end of row
						{
							
							if (vmatchctr >= 3)
							{
								for (var c:int = q1; c <= q2; c++)
								{			
									for (var d:int = p1; d <= p2; d++)
									{	
										TweenMax.to(map[d][c].ref, 2, { blurFilter: { blurX:80, blurY:80, quality:3 }, ease:Quad.easeInOut } );
										this.removeChild(map[d][c].ref);
									}
								}	
								//Bring in new rows from top
								swapJewels(p1, p2, q1, q2,s);									
								return;	
							}
						}
						else
						{
							//Vertical
							if ((map[q+1][p]).jewel == vbasejewel.jewel || (map[q+1][p]).jewel == "wild" || vbasejewel.jewel == "wild")
							{
								
								p2 = q+1;
								q2 = p;		
							}
							else
							{
								vmatchctr = 0;
								vbasejewel = null;
							}						
						}
					}
				}				
			}	
			if (stopped == false)
			{
				disappeartimer = new Timer(2000, 1);
				disappeartimer.addEventListener(TimerEvent.TIMER, matchJewels, false, 0, true);
				disappeartimer.start();				
			}						
		}		
		
		
		private function swapJewels(st_i:int, end_i:int, st_j:int, end_j:int, s:String):void
		{
			if (s == "h" && stopped == false)
			{
				var newx:int, newy:int;
				for (var i:int = st_i; i > 0; i--) 
				{
					
					for (var j:int = st_j; j <= end_j; j++) 
					{	
						newx = map[i][j].ref.x;
						newy = map[i][j].ref.y;
						TweenLite.to(map[i-1][j].ref, 1, { x:newx, y:newy, ease:Elastic.easeIn } );
						
					}
				}
				
				//Swap the map reference
				for (var i:int = st_i; i > 0; i--) 
				{
					for (var j:int = st_j; j <= end_j; j++) 
					{
						var t:Object = map[i][j];
						map[i][j] = map[i - 1][j];
						map[i - 1][j] = t;						
					}
				}
				//Fill the top row
				reousrcestimer = new Timer(1500, 1);
				reousrcestimer.addEventListener(TimerEvent.TIMER, getnewones(0, 0, st_j, end_j, s), false, 0, true);
				reousrcestimer.start();					
				
				
				
			}
			//Vertical matching
			if (s == "v" && stopped == false)
			{
				var newx:int, newy:int;
				for (var j:int = st_j; j <= end_j; j++) 
				{
					
					for (var i:int = 0; i <= st_i; i++) 
					{	
						if (i < st_i)
						{
							newx = map[i + (end_i - st_i) + 1][j].ref.x;
							newy = map[i + (end_i - st_i) + 1][j].ref.y;
							TweenLite.to(map[i][j].ref, 1, { x:newx, y:newy, ease:Elastic.easeIn } );						
						}
						
					}
				}
				//Swap the map reference
				for (var j:int = st_j; j <= end_j; j++) 
				{
					
					for (var i:int = 0; i <= st_i; i++) 
					{
						if (i < st_i)
						{
							var t:Object = map[i + (end_i - st_i) + 1][j];
							map[i + (end_i - st_i) + 1][j] = map[i][j];
							map[i][j] = t;								
						}
					
					}
				}
				//Fill the top column
				reousrcestimer = new Timer(850, 1);
				reousrcestimer.addEventListener(TimerEvent.TIMER, getnewones(0, (end_i - st_i), st_j, end_j, s), false, 0, true);
				reousrcestimer.start();					
				
			}
		}
		
		private function getnewones(a:int, b:int, c:int, d:int, s:String):Function {
		  return function(e:TimerEvent):void {
			  reousrcestimer = null;
			  fillJewels(a, b, c, d, s);
		  };
		}		
		
	}
}

