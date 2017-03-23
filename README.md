# MTPickerViewDemo
使用UIPickerView的时候，因为是监听pickerView的［- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component］方法来获取点选的数据，但是发现如果没有滚动时无法获取pickerView上的数据，所以根据网友的CDZPickerViewDemo－地址：https://github.com/Nemocdz/CDZPickerViewDemo
进行修改增加了cancelBlock和confirmBlock，然后可以不滚动pickerView点击确定直接保存选择。
