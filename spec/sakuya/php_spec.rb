require 'spec_helper'

describe package('php') do
  it { should be_installed }
  #FIXME: この書き方だと4.5.6とかにもマッチしてしまう
  it { should be_installed.with_version('5.6') }
end

describe 'PHP config parameters' do
  # タイムゾーンの設定
  context php_config('date.timezone') do
    its(:value) { should eq 'Asia/Tokyo' }
  end

  # デフォルト文字コード, マルチバイト文字列関数(mbstring)のデフォルトエンコード
  %w{default_charset mbstring.internal_encoding}.each do |name|
    context php_config(name) do
      its(:value) { should eq 'UTF-8' }
    end
  end

  # ショートオープンタグの禁止, バージョンを隠す
  #%w{short_open_tag expose_php}.each do |name|
  #  context php_config(name) do
  #    its(:value) { should eq 'Off' }
  #  end
  #end

  context php_config('mbstring.language') do
    its(:value) {should eq 'Japanese'}
  end

  # HTTP通信の時のインプットとアウトプットの文字コード変換を自動で行わない
  %w{mbstring.http_input mbstring.http_output}.each do |name|
    context php_config(name) do
      its(:value) { should eq 'pass' }
    end
  end

  # 文字コードの自動判別の順番
  context php_config('mbstring.detect_order') do
    its(:value) {should eq 'UTF-8,SJIS,EUC-JP,JIS,ASCII'}
  end
  # 変換に失敗した時に代わりに表示する文字
  #context php_config('mbstring.substitute_character') do
  #
  #  its(:value) {should eq 'none'}
  #end

  #TODO: phpの設定を考えて追加することがあるかもしれない
end

# php_configでうまく取得できないパラメータがあったので、それはこっちでテストする
# TODO: 原因を調べる
describe file('/etc/php.ini') do
  it { should be_file }

  # ショートオープンタグの禁止
  its(:content) { should match /^short_open_tag \= Off/ }
  # バージョンを隠す
  its(:content) { should match /^expose_php \= Off/ }
  # 変換に失敗した時に代わりに表示する文字
  its(:content) { should match /^mbstring.substitute_character \= none\;/ }

end

