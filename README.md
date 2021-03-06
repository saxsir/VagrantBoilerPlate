VagrantBoilerPlate
---

## ローカルに必要な環境
- VirtualBox 4.3.16 以上
	* [VirtualBoxのダウンロードページ](https://www.virtualbox.org/wiki/Downloads)
- Vagrant 1.6.5 以上
	* [Vagrantのダウンロードページ](https://www.vagrantup.com/downloads.html)

```sh
$ vagrant plugin install vagrant-vbguest
$ vagrant plugin install vagrant-omnibus
$ vagrant plugin list

vagrant-login (1.0.1, system)
vagrant-omnibus (1.4.1) #VM環境に自動でchefをインストールするのに必要
vagrant-share (1.1.1, system)
vagrant-vbguest (0.10.0) #自動的にGuest Additionsを更新してくれるプラグイン
```

## 使い方
### 仮想サーバー構築
```sh
$ git clone git@github.com:saxsir/VagrantBoilerPlate.git
$ cd VagrantBoilerPlate
$ vim Vagrantfile
# 必要であれば仮想サーバー名, ローカルIPアドレス, 作業用ユーザー名を書き換える
$ vagrant up
```

### 動作確認

ブラウザで[http://192.168.33.10/phpinfo.php](http://192.168.33.10/phpinfo.php)にアクセスしてPHPの設定ページが見えればたぶん大丈夫。

### サーバーにログイン
```sh
$ vagrant ssh #vagrantユーザーはsudoできる
```

## 仮想サーバー環境構成
### OS
- CentOS 6.5

### Packages
- httpd
	* 自動起動
- php
	* 5.6
- mysql
	* 5.6
	* 自動起動
- iptables
	* 自動起動
	* port22,80 allow
- git, zsh, vim, dstat, tree, unzip, cronie-noanacron, siege, npm, sl

## 自分でレシピを追加したい場合
### bundle install
```sh
$ bundle install --path vendor/bundle
```

### bundle exec knife cookbook create
```sh
$ bundle exec knife cookbook create レシピ名 -o chef/site-cookbooks
```
