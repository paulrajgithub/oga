require 'spec_helper'

describe Oga::CSS::Parser do
  describe ':nth-child pseudo class' do
    it 'parses the x:nth-child(1) pseudo class' do
      parse_css('x:nth-child(1)').should == parse_xpath(
        'descendant::x[count(preceding-sibling::*) = 0]'
      )
    end

    it 'parses the :nth-child(1) pseudo class' do
      parse_css(':nth-child(1)').should == parse_xpath(
        'descendant::*[count(preceding-sibling::*) = 0]'
      )
    end

    it 'parses the :nth-child(2) pseudo class' do
      parse_css(':nth-child(2)').should == parse_xpath(
        'descendant::*[count(preceding-sibling::*) = 1]'
      )
    end

    it 'parses the x:nth-child(even) pseudo class' do
      parse_css('x:nth-child(even)').should == parse_xpath(
        'descendant::x[((count(preceding-sibling::*) + 1) mod 2) = 0]'
      )
    end

    it 'parses the x:nth-child(odd) pseudo class' do
      parse_css('x:nth-child(odd)').should == parse_xpath(
        'descendant::x[(count(preceding-sibling::*) + 1) >= 1 ' \
          'and (((count(preceding-sibling::*) + 1) - 1) mod 2) = 0]'
      )
    end

    it 'parses the x:nth-child(n) pseudo class' do
      parse_css('x:nth-child(n)').should == parse_xpath(
        'descendant::x[((count(preceding-sibling::*) + 1) mod 1) = 0]'
      )
    end

    it 'parses the x:nth-child(-n) pseudo class' do
      parse_css('x:nth-child(-n)').should == parse_xpath(
        'descendant::x[((count(preceding-sibling::*) + 1) mod 1) = 0]'
      )
    end

    it 'parses the x:nth-child(-n+6) pseudo class' do
      parse_css('x:nth-child(-n+6)').should == parse_xpath(
        'descendant::x[((count(preceding-sibling::*) + 1) <= 6) ' \
          'and (((count(preceding-sibling::*) + 1) - 6) mod 1) = 0]'
      )
    end

    it 'parses the x:nth-child(n+5) pseudo class' do
      parse_css('x:nth-child(n+5)').should == parse_xpath(
        'descendant::x[(count(preceding-sibling::*) + 1) >= 5 ' \
          'and (((count(preceding-sibling::*) + 1) - 5) mod 1) = 0]'
      )
    end

    it 'parses the x:nth-child(2n) pseudo class' do
      parse_css('x:nth-child(2n)').should == parse_css('x:nth-child(even)')
    end

    it 'parses the x:nth-child(2n+1) pseudo class' do
      parse_css('x:nth-child(2n+1)').should == parse_xpath(
        'descendant::x[(count(preceding-sibling::*) + 1) >= 1 ' \
          'and (((count(preceding-sibling::*) + 1) - 1) mod 2) = 0]'
      )
    end

    it 'parses the x:nth-child(3n+1) pseudo class' do
      parse_css('x:nth-child(3n+1)').should == parse_xpath(
        'descendant::x[(count(preceding-sibling::*) + 1) >= 1 ' \
          'and (((count(preceding-sibling::*) + 1) - 1) mod 3) = 0]'
      )
    end

    it 'parses the x:nth-child(2n-6) pseudo class' do
      parse_css('x:nth-child(2n-6)').should == parse_xpath(
        'descendant::x[(count(preceding-sibling::*) + 1) >= 2 ' \
          'and (((count(preceding-sibling::*) + 1) - 2) mod 2) = 0]'
      )
    end

    it 'parses the x:nth-child(-2n+6) pseudo class' do
      parse_css('x:nth-child(-2n+6)').should == parse_xpath(
        'descendant::x[((count(preceding-sibling::*) + 1) <= 6) ' \
          'and (((count(preceding-sibling::*) + 1) - 6) mod 2) = 0]'
      )
    end
  end
end
