# frozen_string_literal: true

require 'string_calculator'

RSpec.describe StringCalculator do
  describe 'add' do
    context 'Valid Input' do
      it 'Should return 1' do
        calculator = StringCalculator.new('1')
        expect(calculator.add).to eq(1)
      end

      it 'Should return sum of the inputs, eql to 7' do
        calculator = StringCalculator.new('2,5')
        expect(calculator.add).to eq(7)
      end

      it 'Should return sum of the inputs, eql to 6' do
        calculator = StringCalculator.new('1,2,3')
        expect(calculator.add).to eq(6)
      end

      it 'Should return sum of the inputs, eql to 9 with \n as well' do
        calculator = StringCalculator.new('2\n3,4')
        expect(calculator.add).to eq(9)
      end

      it 'Should return sum of the inputs, eql to 11 with multiple \n as well' do
        calculator = StringCalculator.new('2\n2,\n7\n5')
        expect(calculator.add).to eq(16)
      end
    end

    context 'Custom Delimiter' do
      it 'Should return sum of the inputs with custom delimiter(;), eql to 8' do
        calculator = StringCalculator.new('//;\n4;4')
        expect(calculator.add).to eq(8)
      end

      it 'Should return sum of the inputs with custom delimiter(:), eql to 11 ' do
        calculator = StringCalculator.new('//:\n5:6')
        expect(calculator.add).to eq(11)
      end
    end

    context 'Negative Number Input' do
      it 'Should retun negative number error' do
        calculator = StringCalculator.new('5,8,-10,-20')
        expect(calculator.add).to eq('Negative numbers are not allowed: -10, -20')
      end
    end

    context 'Invalid Input' do
      it 'Should return an invalid inputs error with , delimiter' do
        calculator = StringCalculator.new('3,2,1,')
        expect(calculator.add).to eq('Invalid Inputs')
      end

      it 'Should return an invalid inputs error with \n' do
        calculator = StringCalculator.new('3,\n')
        expect(calculator.add).to eq('Invalid Inputs')
      end

      it 'Should return an invalid inputs error with custom delimiter(:)' do
        calculator = StringCalculator.new('//:\n5:')
        expect(calculator.add).to eq('Invalid Inputs')
      end
    end
  end
end
