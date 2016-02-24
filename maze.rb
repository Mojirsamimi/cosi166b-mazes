
class Maze
  def initialize(column,row)
    @column=column
    @row=row
    @visited=Array.new(row*column)
    @trace=""
  end
  
  def load
    
    r=2*@row-1
    c=2*@column-1
    @maze_string="1"*(c+2)
    r.times do |i|
      rm=i%2
      
      @maze_string+="1"
      c.times do |j|
        cm=j%2
        
        if rm | cm==0
          @maze_string+="0"
        elsif rm & cm ==1
          @maze_string+="1"
        else
          @maze_string+=rand(2).to_s
        end   
      end
      @maze_string+="1"
    end
    @maze_string+="1"*(c+2)
  end
  
  def display
    r=2*@row+1
    c=2*@column+1
   
    r.times do |i|
      maze_row=@maze_string[i*c,c]
      maze_row.gsub!("0"," ")
      if i%2==0
        maze_row.chars.each_index do |indx|
          if indx%2==0
            maze_row[indx]="+"
          elsif maze_row[indx]=="1"
            maze_row[indx]="-"
          end
        end
      else
        maze_row.gsub!("1","|")
      end
      puts maze_row
      
    end
   
  end
  
  def display2
    r=2*@row+1
    c=2*@column+1
   
    r.times do |i|
      puts @maze_string[i*c,c]
    end
   
  end
  
  def solve(beg_x,beg_y,end_x,end_y)
    @visited.clear
    return solve2(beg_x,beg_y,end_x,end_y)
  end
  
  def solve2(beg_x,beg_y,end_x,end_y)
    @visited[beg_y*@column+beg_x]=1
    
    if beg_x==end_x && beg_y==end_y
      return true
    end
    if can_go?("right",beg_x,beg_y) && solve2(beg_x+1,beg_y,end_x,end_y)==true
      @trace="right "+@trace
      return true
    elsif can_go?("left",beg_x,beg_y) && solve2(beg_x-1,beg_y,end_x,end_y)==true
      @trace="left "+@trace
      return true
    elsif can_go?("up",beg_x,beg_y) && solve2(beg_x,beg_y-1,end_x,end_y)==true
      @trace="up "+@trace
      return true
    elsif can_go?("down",beg_x,beg_y) && solve2(beg_x,beg_y+1,end_x,end_y)==true
      @trace="down "+@trace
      return true
    end
    return false
  end
  
  def can_go?(dir,x,y)
    
    if dir=="right"
      if x==@column-1 || @visited[y*@column+x+1]!=nil
        return false
      end
      cell_mid=@maze_string[(2*y+1)*(2*@column+1)+(2*x),3]
      return cell_mid[2]=="0"
    elsif dir=="left"
      if x==0 || @visited[y*@column+x-1]!=nil
        return false
      end
      cell_mid=@maze_string[(2*y+1)*(2*@column+1)+(2*x),3]
      return cell_mid[0]=="0"
    elsif dir=="up"
      if y==0 || @visited[(y-1)*@column+x]!=nil
        return false
      end
      cell_top=@maze_string[(2*y)*(2*@column+1)+(2*x),3]
      return cell_top[1]=="0"
    elsif dir=="down"
      if y==@row-1 || @visited[(y+1)*@column+x]!=nil
        return false
      end
      cell_btm=@maze_string[(2*y+2)*(2*@column+1)+(2*x),3]
      return cell_btm[1]=="0"
    end
    return false
  end
  
  def trace(beg_x,beg_y,end_x,end_y)
    if solve(beg_x,beg_y,end_x,end_y)==true
      return @trace
    end
    return "There is no way between start and end points"
  end
  
  def redesign
    load
  end
    
end


