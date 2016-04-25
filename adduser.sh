#!/bin/sh

input_pass(){
    for i in `seq 1 1 2`
    do
	sleep 1;echo "tdomen"
    done
}

input_enter(){
    for i in `seq 1 1 6`
    do
	sleep 1;echo ""
    done
}

# 引数のチェック
if [ $# -ne 2 ]; then
  echo "指定された引数は$#個です。" 1>&2
  echo "実行するには2個の引数が必要です。" 1>&2
  exit 1
fi

# 引数の格納
USERNAME=$1
KEY_PATH=$2

# echo $USERNAME
# echo $KEY_PATH

# ユーザ追加
(input_pass;sleep 1;input_enter;)|adduser $USERNAME
gpasswd -a $USERNAME fomalhaut

# 公開鍵の登録
mkdir /home/$USERNAME/.ssh
cd /home/$USERNAME/.ssh
touch authorized_keys
cat $KEY_PATH >> authorized_keys
#chmod 600 /home/$USERNAME/.ssh/authorized_keys
#rm $KEY_NAME
