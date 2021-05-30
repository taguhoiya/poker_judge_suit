class PokerController < ApplicationController

  def index

  end

  def create
      @n_arrays = [params[:num1].to_i, params[:num2].to_i, params[:num3].to_i, params[:num4].to_i, params[:num5].to_i]
      @m_arrays = [params[:mark1], params[:mark2], params[:mark3], params[:mark4], params[:mark5]]

      @count_n = @n_arrays.uniq.count
      @count_m = @m_arrays.uniq.count
      
      @repeat = @n_arrays.group_by(&:itself).map{ |key, value| [key, value.count] }.sort{ |a, b| a[1] <=> b[1] }
      @overlap = @repeat.map{|row| row[1]}
      @key = @repeat.map{|fac| fac[0]}.sort

      for num in 1..9
          #1<=n<=13 1<=m<=4
          #ロイヤルストレートフラッシュ…同じマークのA・K・Q・J・10
          if @n_arrays.uniq.sort == [1, 10, 11, 12, 13]   && @count_m == 1 
              @text = "ロイヤルストレートフラッシュ"
              render :index and return
          
          #ストレートフラッシュ…同じマークで連番
          elsif @count_m == 1 && @key == [num, num+1, num+2, num+3, num+4]
              @text = "ストレートフラッシュ"
              render :index and return        
          
          #フォーカード…同じ数字が4枚
          elsif @overlap == [1, 4]
              @text = "フォーカード"
              render :index and return

          #フルハウス…同じ数字が3枚と同じ数字が2枚の組み合わせ
          elsif @overlap == [2, 3]
              @text = "フルハウス"
              render :index and return

          #ストレート…連番
          elsif @key == [num, num+1, num+2, num+3, num+4] && @overlap == [1, 1, 1, 1, 1]
              @text = "ストレート"
              render :index and return

          #フラッシュ…同じマークが5枚
          elsif @count_m == 1 && @overlap == [1, 1, 1, 1, 1]
              @text = "フラッシュ"
              render :index and return
          
          #スリーカード…同じ数字が3枚
          elsif @overlap == [1, 1, 3] 
              @text = "スリーカード"
              render :index and return

          #ツーペア
          elsif @overlap == [1, 2, 2] 
              @text = "ツーペア"
              render :index and return

          #ワンペア
          elsif @overlap == [1, 1, 1, 2]
              @text = "ワンペア"
              render :index and return

          else 
              @text = "ノーペア"
              render :index and return
          end
      end
  end

end
