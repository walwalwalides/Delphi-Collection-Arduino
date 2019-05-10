
//{ ============================================
//  Software Name : 	Digi7Segment
//  ============================================ }
//{ ******************************************** }
//{ Written By WalWalWalides                     }
//{ CopyRight © 2019                             }
//{ Email : WalWalWalides@gmail.com              }
//{ GitHub :https://github.com/walwalwalides     }
//{ ******************************************** }
void Zero()
{
digitalWrite(E,HIGH);
digitalWrite(D,HIGH);
digitalWrite(C,HIGH);
digitalWrite(DP,LOW);
digitalWrite(B,HIGH);
digitalWrite(A,HIGH);
digitalWrite(F,HIGH);
digitalWrite(G,LOW);
}
void One ()
{
digitalWrite(E,LOW);
digitalWrite(D,LOW);
digitalWrite(C,HIGH);
digitalWrite(DP,LOW);
digitalWrite(B,HIGH);
digitalWrite(A,LOW);
digitalWrite(F,LOW);
digitalWrite(G,LOW);
}
void Tow ()
{
digitalWrite(E,HIGH);
digitalWrite(D,HIGH);
digitalWrite(C,LOW);
digitalWrite(DP,LOW);
digitalWrite(B,HIGH);
digitalWrite(A,HIGH);
digitalWrite(F,LOW);
digitalWrite(G,HIGH);
}
void Three ()
{
digitalWrite(E,LOW);
digitalWrite(D,HIGH);
digitalWrite(C,HIGH);
digitalWrite(DP,LOW);
digitalWrite(B,HIGH);
digitalWrite(A,HIGH);
digitalWrite(F,LOW);
digitalWrite(G,HIGH);
}
void Four ()
{
digitalWrite(E,LOW);
digitalWrite(D,LOW);
digitalWrite(C,HIGH);
digitalWrite(DP,LOW);
digitalWrite(B,HIGH);
digitalWrite(A,LOW);
digitalWrite(F,HIGH);
digitalWrite(G,HIGH);
}
void Five ()
{
digitalWrite(E,LOW);
digitalWrite(D,HIGH);
digitalWrite(C,HIGH);
digitalWrite(DP,LOW);
digitalWrite(B,LOW);
digitalWrite(A,HIGH);
digitalWrite(F,HIGH);
digitalWrite(G,HIGH);
}
void Six ()
{
digitalWrite(E,HIGH);
digitalWrite(D,HIGH);
digitalWrite(C,HIGH);
digitalWrite(DP,LOW);
digitalWrite(B,LOW);
digitalWrite(A,HIGH);
digitalWrite(F,HIGH);
digitalWrite(G,HIGH);
}
void Seven ()
{
digitalWrite(E,LOW);
digitalWrite(D,LOW);
digitalWrite(C,HIGH);
digitalWrite(DP,LOW);
digitalWrite(B,HIGH);
digitalWrite(A,HIGH);
digitalWrite(F,LOW);
digitalWrite(G,LOW);
}
void Eight ()
{
digitalWrite(E,HIGH);
digitalWrite(D,HIGH);
digitalWrite(C,HIGH);
digitalWrite(DP,LOW);
digitalWrite(B,HIGH);
digitalWrite(A,HIGH);
digitalWrite(F,HIGH);
digitalWrite(G,HIGH);
}
void Nine ()
{
digitalWrite(E,LOW);
digitalWrite(D,HIGH);
digitalWrite(C,HIGH);
digitalWrite(DP,LOW);
digitalWrite(B,HIGH);
digitalWrite(A,HIGH);
digitalWrite(F,HIGH);
digitalWrite(G,HIGH);
}
void Point ()
{
digitalWrite(E,LOW);
digitalWrite(D,LOW);
digitalWrite(C,LOW);
digitalWrite(DP,HIGH);
digitalWrite(B,LOW);
digitalWrite(A,LOW);
digitalWrite(F,LOW);
digitalWrite(G,LOW);
}
